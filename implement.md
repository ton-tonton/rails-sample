# Implementation Plan

A structured guide to building the book rental application, progressing from basic requirements to production-ready optimizations.

## Phase 1: Core Setup & Functionality

### Step 1: Scaffolding Models
Generate the base models and database schema.

```bash
rails g scaffold Book title:string author:string status:integer
rails g scaffold Rental book:references renter_name:string rented_at:datetime returned_at:datetime
rails db:migrate
```

### Step 2: Model Configuration
`app/models/book.rb`

```ruby
class Book < ApplicationRecord
  enum :status, available: 0, rented: 1

  has_many :rentals, dependent: :destroy
end
```

`app/models/rental.rb`

```ruby
class Rental < ApplicationRecord
  belongs_to :book
end
```

### Step 3: Dashboard Setup
Create a controller and view to display books.

```bash
rails g controller Dashboard index
```

**Routes (`config/routes.rb`):**
```ruby
root 'dashboard#index'
```

**Controller (`app/controllers/dashboard_controller.rb`):**
```ruby
class DashboardController < ApplicationController
  def index
    @books = Book.includes(:rentals).all
  end
end
```

**View (`app/views/dashboard/index.html.erb`):**
```erb
<h1>Book Rental</h1>

<table>
  <thead>
    <tr>
      <th>Title</th>
      <th>Author</th>
      <th>Status</th>
      <th>Current Renter</th>
      <th>Stats</th>
    </tr>
  </thead>
  <tbody>
    <% @books.each do |book| %>
      <tr>
        <td><%= book.title %></td>
        <td><%= book.author %></td>
        <td><%= book.status.capitalize %></td>
        <td><%= book.rented? ? book.rentals.last.renter_name : "N/A" %></td>
        <td><%= book.rentals.size %> rentals</td>
      </tr>
    <% end %>
  </tbody>
</table>
```

---

## Phase 2: Business Logic & Validation

### Step 4: Enforce Rental Rules
Ensure a book cannot be rented if it's already out. Add validation to `app/models/rental.rb`.

```ruby
class Rental < ApplicationRecord
  belongs_to :book

  validate :book_must_be_available, on: :create

  private

  def book_must_be_available
    if book.rentals.where(returned_at: nil).exists?
      errors.add(:base, "This book is currently unavailable.")
    end
  end
end
```

### Step 5: State Automation
Use callbacks to automatically toggle book status when rentals are created or returned.

**In `app/models/rental.rb`:**
```ruby
after_create :mark_book_as_rented
after_update :mark_book_as_available

private

def mark_book_as_rented
  book.rented!
end

def mark_book_as_available
  if returned_at_previous_change.nil? && returned_at.present?
    book.available!
  end
end
```

---

## Phase 3: Performance & Scalability (Optimization)

### Step 6: Memory Management (Pagination)
Avoid loading all records at once by using `pagy`.

**Gemfile:**
```ruby
gem 'pagy', '~> 43.2'
```

**Controller:**
```ruby
include Pagy::Method

def index
  @pagy, @books = pagy(:offset, Book.includes(:rentals).all)
end
```

**View:**
```erb
<%== @pagy.series_nav %>
```

### Step 7: Optimizing Counts (Counter Cache)
Avoid N+1 count queries by caching the rental count on the book model.

**Migration:**
```bash
rails g migration AddRentalsCountToBooks rentals_count:integer
```

**Update Migration File:**
```ruby
add_column :books, :rentals_count, :integer, default: 0, null: false
```

**Model (`app/models/rental.rb`):**
```ruby
belongs_to :book, counter_cache: true
```

**View Update:**
Use the column directly instead of counting the association.
```erb
<td><%= book.rentals_count %> rentals</td>
```

### Step 8: Optimizing Associations (Scoped Has One)
Optimized fetching of the current renter to avoid loading all rental history.

**Model (`app/models/book.rb`):**
```ruby
has_one :active_rental, -> { where(returned_at: nil) }, class_name: "Rental"
```

**Controller:**
Preload the specific association.
```ruby
@pagy, @books = pagy(:offset, Book.includes(:active_rental).all)
```

**View Update:**
```erb
<%= book.rented? ? book.active_rental&.renter_name : "N/A" %>
```
