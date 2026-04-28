# 🍂 KOMOREBI

A Japanese learning application designed for Brazilian Portuguese speakers studying Japanese through structured progression in **Kanji, Vocabulary, and Grammar**, aligned with JLPT levels.

Built with Ruby on Rails, Komorebi focuses on backend architecture for educational systems and long-term retention models.

---

# 🧠 Overview

Komorebi is a structured learning system for Japanese that organizes content into three main domains:

- Kanji
- Vocabulary
- Grammar

All content is aligned with JLPT levels (N5 → N1), providing a progressive learning path.

The system is designed around retention-based learning principles inspired by spaced repetition.

---

# 📚 Learning Domains

## 🈶 Kanji
- JLPT-based Kanji organization (N5 → N1)
- Meanings and readings (on/kun)
- Structured progression by difficulty level

## 📖 Vocabulary (in progress)
- JLPT-aligned vocabulary items
- Association with Kanji and usage context
- Foundation for future review system expansion

## 🧩 Grammar (in progress)
- Grammar points structured by JLPT level
- Planned support for examples and usage patterns

---

# 🧠 Learning System Concept

- Review-based learning model inspired by spaced repetition principles
- User progress tracking per learning item
- Retention-focused structure instead of linear learning
- Extensible design for multiple content types (Kanji, Vocabulary, Grammar)

> ReviewCard serves as the persistence layer for the SRS engine.
>
> Spaced repetition service layer is currently in development.

---

# 🏗️ Architecture Highlights

- Ruby on Rails backend architecture
- Polymorphic `ReviewCard` system for multiple learning types
- Domain separation between:
    - Kanji
    - Vocabulary
    - Grammar
    - Review system
- Database-level constraints for data integrity
- Test-driven development using RSpec

---

# 🧩 Core Models

- `User` — application users
- `JlptLevel` — JLPT hierarchy (N5 → N1)
- `Kanji` — Japanese characters with meanings and readings
- `ReviewCard` — polymorphic review tracking system

> Vocabulary and Grammar models are planned / under development.

---

# 🧪 Testing Strategy

- RSpec for model and system behavior
- FactoryBot for test data generation
- Database constraint validation tests

---

# 🚧 Current Status

- Kanji learning system implemented
- JLPT structure implemented
- Review tracking system implemented
- Vocabulary module in early development (schema defined, implementation in progress)
- Grammar module in early development (domain modeling in progress)
- SRS service layer (spaced repetition engine) in progress

---

# ⚙️ Tech Stack

- Ruby on Rails
- PostgreSQL
- RSpec
- FactoryBot
- ActiveRecord

---

# 🎯 Purpose

Komorebi was built as an engineering exploration of:

- structured language learning systems
- backend architecture for educational platforms
- scalable learning data modeling

---

# 📷 Logo

![Logo](/app/assets/images/komorebi-logo.png)