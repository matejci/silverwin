# Copilot Instructions for Personal Goal Demo Rails App

## Project Overview
This is a Rails 7.2+ application with PostgreSQL, built as a Progressive Web App (PWA) using modern Rails conventions. The app follows Rails 7's "no-build" approach with import maps and Stimulus controllers.

## Architecture & Tech Stack
- **Rails 7.2.2+** with Ruby 3.3.6
- **Frontend**: Hotwire (Turbo + Stimulus), Import Maps (no webpack/esbuild)
- **Database**: PostgreSQL with standard Rails conventions
- **Background Jobs**: Sidekiq with Redis for async processing
- **PWA**: Built-in Rails PWA support with manifest and service worker
- **Styling**: Tailwind CSS with standalone CLI, built via Rails asset pipeline
- **Testing**: Rails test suite with system tests using Chrome

## Key Development Patterns

### Frontend Architecture
- **Import Maps**: Use `bin/importmap` to manage JavaScript dependencies, configured in `config/importmap.rb`
- **Stimulus Controllers**: Place in `app/javascript/controllers/` and follow naming convention (snake_case files, PascalCase classes)
- **Turbo**: Leverages Turbo for SPA-like navigation without full page reloads
- **PWA**: Manifest at `app/views/pwa/manifest.json.erb`, service worker at `app/views/pwa/service-worker.js`

### Code Quality & CI
- **Linting**: Uses `rubocop-rails-omakase` - run with `bin/rubocop`
- **Security**: Brakeman for Ruby (`bin/brakeman`) and import map auditing (`bin/importmap audit`)
- **Testing**: Run full suite with `bin/rails test test:system`
- **Browser Support**: Only modern browsers supporting CSS nesting, import maps, and :has selector

### Development Workflow
```bash
# Setup
bin/setup

# Development server (with Tailwind watch + Sidekiq)
bin/dev                     # Runs Rails server, Tailwind watcher, and Sidekiq worker
bin/rails server            # Rails server only
bundle exec sidekiq         # Sidekiq worker only

# Run tests
bin/rails test              # Unit/integration tests
bin/rails test:system       # System tests with Chrome
bin/rails db:test:prepare   # Prepare test database

# Code quality
bin/rubocop                 # Linting
bin/brakeman               # Security scanning
bin/importmap audit        # JS dependency security

# Tailwind CSS
bin/rails tailwindcss:build     # One-time build
bin/rails tailwindcss:watch     # Watch mode for development

# Background jobs
rails console               # Access Rails console to enqueue jobs manually
# Visit /sidekiq for web dashboard
```

### Database & Models
- PostgreSQL with standard Rails migrations in `db/migrate/`
- Models follow ActiveRecord conventions in `app/models/`
- Seeds in `db/seeds.rb`

### Deployment
- **Docker**: Production-ready Dockerfile with multi-stage build
- **CI/CD**: GitHub Actions workflow in `.github/workflows/ci.yml` runs tests, linting, and security scans
- **Database**: Uses `DATABASE_URL` environment variable for connections

## File Structure Notes
- Controllers in `app/controllers/` with `ApplicationController` base class enforcing modern browser support
- Views use ERB templates with application layout in `app/views/layouts/`
- JavaScript entry point at `app/javascript/application.js`
- Stimulus controllers auto-loaded from `app/javascript/controllers/`
- PWA files in `app/views/pwa/` for manifest and service worker
- Tailwind CSS source in `app/assets/tailwind/application.css`, builds to `app/assets/builds/`

## Common Tasks
- **Add new Stimulus controller**: Create `app/javascript/controllers/[name]_controller.js`
- **Add new route**: Update `config/routes.rb` following RESTful conventions
- **Add JavaScript dependency**: Use `bin/importmap pin [package]`
- **New database changes**: Generate migration with `bin/rails g migration`