# Komorebi (木漏れ日)

A backend-focused Japanese learning system implementing a **Spaced Repetition System (SM-2 algorithm)** for long-term retention.

Originally designed for Brazilian Portuguese speakers, Komorebi structures learning across **Kanji, Vocabulary, and Grammar**, aligned with JLPT levels.

---

## Spaced Repetition System (SRS)

Komorebi implements a simplified version of the SM-2 algorithm (used in systems like Anki) to optimize long-term memory retention.

### How it works

1. User reviews a learning item with a quality score (0–5)
2. The system recalculates:

  * review interval
  * ease factor
  * next review date
3. The updated state is persisted in `ReviewCard`
4. A `ReviewLog` is created for historical tracking and analysis

### Example

```ruby
Cards::Grade.call(
  card: review_card,
  quality: 4,
  response_time_ms: 1200
)
```

### Responsibilities

* `Srs::Sm2Calculator` — core scheduling algorithm
* `Cards::Grade` — transactional orchestration of review logic
* `ReviewCard` — current learning state
* `ReviewLog` — historical review data

### Key behaviors

* Resets repetition on low-quality responses
* Dynamically adjusts difficulty via ease factor
* Enforces minimum ease factor (SM-2 constraint)
* Uses transactional updates to guarantee consistency

---

## Architecture

* Ruby on Rails backend architecture
* Polymorphic `ReviewCard` system supporting multiple learning domains
* Clear separation between domain logic and orchestration layer
* Transactional consistency using service/interactor pattern
* Database-level constraints ensuring data integrity
* Test-driven development with RSpec

---

## Learning Domains

### Kanji (Implemented)

* JLPT-based organization (N5 → N1)
* Meanings and readings (on/kun)
* Structured progression by difficulty

### Vocabulary (Planned)

* JLPT-aligned vocabulary items
* Association with Kanji and contextual usage

### Grammar (Planned)

* Grammar points structured by JLPT level
* Planned support for examples and usage patterns

---

## Core Models

* `User` — application users
* `JlptLevel` — JLPT hierarchy (N5 → N1)
* `Kanji` — characters with meanings and readings
* `ReviewCard` — polymorphic review tracking system
* `ReviewLog` — historical performance tracking

---

## Testing Strategy

* RSpec for domain and service behavior
* FactoryBot for test data generation
* Validation of business rules and database constraints
* Transaction and failure scenario coverage

---

## Current Status

* Kanji domain implemented
* JLPT structure implemented
* Spaced Repetition System (SM-2) implemented
* Review tracking and logging system implemented

The system is being expanded to support additional learning domains and richer user interaction flows.

---

## Purpose

Komorebi was built to demonstrate backend engineering skills in:

* data modeling for learning systems
* implementation of spaced repetition algorithms
* transactional business logic
* scalable and extensible system design
* test-driven development

---

## Tech Stack

* Ruby on Rails
* PostgreSQL
* RSpec
* FactoryBot
* ActiveRecord

---

## Logo

![Komorebi Logo](app/assets/images/komorebi-logo.png)
