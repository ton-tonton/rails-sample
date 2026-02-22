# Rails: Book Rental System

**Goal:** Build a simple Book Rental tracking system.

## Requirements

### 1. Data Models & Database
Create the necessary models and migrations with appropriate attributes.

**Suggested Schema:**

```mermaid
erDiagram
  Book ||--o{ Rental : "has_many"

  Book {
    string title
    string author
    integer status "enum: available, rented"
  }

  Rental {
    integer book_id
    string renter_name
    datetime rented_at
    datetime returned_at
  }
```

*   **Book**: Represents a book in the library.
*   **Rental**: Represents a rental transaction. A book can have many rentals (history), but only one *active* rental at a time.

### 2. Features

1.  **CRUD Operations**: Implement basic Create, Read, Update, Delete for `Book` and `Rental` models.
2.  **Dashboard (Root Path)**:
  *   Display a list of **all books**.
  *   For each book, display its **Status**:
      *   **Available**: The book is ready to be rented.
      *   **Rented**: The book is currently out.
  *   **Current Rental Info**: If a book is rented, display the current renter's name.
  *   **Stats**: Display a generic counter showing the **Total Number of Books Currently Rented**.

**Example Dashboard Table:**

| Title | Author | Status | Current Renter | Stats |
|---|---|---|---|---|
| The Pragmatic Programmer | David Thomas, Andrew Hunt | Available | - | 15 total rentals |
| Clean Code | Robert C. Martin | Rented | Alice Smith | 42 total rentals |
| Refactoring | Martin Fowler | Available | - | 8 total rentals |
