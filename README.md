# Komorebi (木漏れ日)

A backend-focused Japanese learning system implementing a Spaced Repetition System (SM-2 algorithm) for long-term retention.

Originally designed for Brazilian Portuguese speakers, Komorebi structures learning across Kanji, Vocabulary, and Grammar, aligned with JLPT levels.

---

## V.0.0.1 Demo Video

[![Watch the Komorebi Demo](https://img.youtube.com/vi/tEHt8BJK7vM/maxresdefault.jpg)](https://www.youtube.com/watch?v=tEHt8BJK7vM)  
Click the image above to watch the demonstration.

## Spaced Repetition System (SRS)

Komorebi implements a simplified version of the SM-2 algorithm (used in systems like Anki) to optimize long-term memory retention.

How it works

1. User reviews a learning item with a quality score (0-5).
2. The system recalculates:
   * Review interval: The gap until the next session.
   * Ease factor: A multiplier that adjusts based on performance.
   * Next review date: Scheduled according to the algorithm's output.
3. The updated state is persisted in ReviewCard.
4. A ReviewLog is created for historical tracking and analysis.

## Technical Implementation

```ruby
Example of a review orchestration
Cards::Grade.call(
        card: review_card,
        quality: 4,
        response_time_ms: 1200
)
```

## Responsibilities

* Srs::Sm2Calculator — Core scheduling algorithm.
* Cards::Grade — Transactional orchestration of review logic.
* ReviewCard — Current learning state (polymorphic).
* ReviewLog — Historical review data for analytics.

---

## Architecture

* Ruby on Rails backend architecture focused on clean domain logic.
* Polymorphic ReviewCard system supporting multiple learning domains.
* Service/Interactor pattern for transactional consistency and business logic isolation.
* Database-level constraints ensuring data integrity at the PostgreSQL layer.
* Test-Driven Development with a robust RSpec suite.

---

## Learning Domains

### Kanji (In Progress)

* JLPT Organization: Structured from N5 to N1.
* Comprehensive Data: Includes meanings, On'yomi, and Kun'yomi readings.
* Progression: Logic-based flow by character difficulty.
* Note: The Kanji learning feature is currently under active development.

### Vocabulary & Grammar (Planned)

* Vocabulary: JLPT-aligned items with contextual usage.
* Grammar: Structural points with support for example patterns.

---

## Testing Strategy

* RSpec: Full coverage of domain behavior and service objects.
* Capybara: Acceptance tests for user interaction flows.
* FactoryBot: Efficient test data generation.
* Integration Tests: Validation of business rules and database state transitions.

---

## Current Status & Purpose

The system is currently in its initial phase, focusing on a solid backend foundation. It was built to demonstrate engineering proficiency in:

* Complex Data Modeling: Handling educational structures.
* Algorithm Implementation: Real-world application of SM-2 logic.
* Scalable Design: Extensible architecture for new learning domains.

---

## Tech Stack

* Ruby on Rails
* Ruby
* PostgreSQL
* Hotwire (Turbo/Stimulus)
* Tailwind CSS
* RSpec, Capybara, and FactoryBot
