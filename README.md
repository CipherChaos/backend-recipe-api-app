# Recipe Management API

A production-ready RESTful API for managing recipes, built with Django and Django REST Framework. This API allows users to create, manage, and organize recipes with tags and ingredients, featuring advanced filtering capabilities and image upload functionality.

## Features

- **User Authentication**: Token-based authentication system for secure API access
- **Recipe Management**: Full CRUD operations for recipes with support for:
  - Recipe creation, retrieval, update, and deletion
  - Image upload for recipes
  - Tag and ingredient association
- **Advanced Filtering**: Query recipes by tags and ingredients
- **API Documentation**: Interactive Swagger/OpenAPI documentation
- **Production Ready**: Dockerized deployment with uWSGI and Nginx
- **Test Coverage**: Comprehensive test suite following TDD practices
- **Database Health Checks**: Custom management commands for database connectivity

## Tech Stack

- **Framework**: Django 5.2.6, Django REST Framework 3.16.1
- **Database**: PostgreSQL 18
- **Server**: uWSGI (WSGI server)
- **Web Server**: Nginx (reverse proxy)
- **Containerization**: Docker, Docker Compose
- **API Documentation**: drf-spectacular (OpenAPI/Swagger)
- **Image Processing**: Pillow
- **Environment Management**: django-environ

## Prerequisites

- Docker and Docker Compose
- Python 3.13+ (for local development)
- PostgreSQL (if running without Docker)

## Installation

### Using Docker (Recommended)

1. Clone the repository:
```bash
git clone <repository-url>
cd backend-recipe-api-app
```

2. Create a `.env` file in the root directory:
```env
DJANGO_SECRET_KEY=your-secret-key-here
DEBUG=True
DJANGO_ALLOWED_HOSTS=localhost,127.0.0.1
DATABASE_NAME=recipe_db
DATABASE_USERNAME=recipe_user
DATABASE_PASSWORD=recipe_password
DATABASE_HOST=db
DATABASE_PORT=5432
```

3. Run the development environment:
```bash
docker-compose up
```

The API will be available at `http://localhost:8000`

### Local Development Setup

1. Create a virtual environment:
```bash
python -m venv .venv
source .venv/bin/activate  # On Windows: venv\Scripts\activate
```

2. Install dependencies:
```bash
pip install -r requirements.txt
pip install -r requirements.dev.txt
```

3. Set up environment variables (create `.env` file in `app/` directory):
```env
DJANGO_SECRET_KEY=your-secret-key-here
DEBUG=True
DJANGO_ALLOWED_HOSTS=localhost,127.0.0.1
DATABASE_NAME=recipe_db
DATABASE_USERNAME=recipe_user
DATABASE_PASSWORD=recipe_password
DATABASE_HOST=localhost
DATABASE_PORT=5432
```

4. Run migrations:
```bash
cd app
python manage.py migrate
```

5. Create a superuser:
```bash
python manage.py createsuperuser
```

6. Run the development server:
```bash
python manage.py runserver
```

## Configuration

### Environment Variables

- `DJANGO_SECRET_KEY`: Django secret key for cryptographic signing
- `DEBUG`: Set to `True` for development, `False` for production
- `DJANGO_ALLOWED_HOSTS`: Comma-separated list of allowed hosts
- `DATABASE_NAME`: PostgreSQL database name
- `DATABASE_USERNAME`: PostgreSQL database user
- `DATABASE_PASSWORD`: PostgreSQL database password
- `DATABASE_HOST`: Database host (default: `db` for Docker, `localhost` for local)
- `DATABASE_PORT`: Database port (default: `5432`)

## API Endpoints

### Authentication

- `POST /api/user/create/` - Create a new user
- `POST /api/user/token/` - Obtain authentication token
- `GET /api/user/profile/` - Get user profile (authenticated)
- `PUT /api/user/profile/` - Update user profile (authenticated)
- `PATCH /api/user/profile/` - Partially update user profile (authenticated)

### Recipes

- `GET /api/recipe/recipes/` - List all recipes (authenticated)
- `POST /api/recipe/recipes/` - Create a new recipe (authenticated)
- `GET /api/recipe/recipes/{id}/` - Get recipe details (authenticated)
- `PUT /api/recipe/recipes/{id}/` - Update recipe (authenticated)
- `PATCH /api/recipe/recipes/{id}/` - Partially update recipe (authenticated)
- `DELETE /api/recipe/recipes/{id}/` - Delete recipe (authenticated)
- `POST /api/recipe/recipes/{id}/upload-image/` - Upload recipe image (authenticated)

**Query Parameters:**
- `tags`: Comma-separated list of tag IDs to filter recipes
- `ingredients`: Comma-separated list of ingredient IDs to filter recipes

### Tags

- `GET /api/recipe/tags/` - List all tags (authenticated)
- `POST /api/recipe/tags/` - Create a new tag (authenticated)
- `PUT /api/recipe/tags/{id}/` - Update tag (authenticated)
- `PATCH /api/recipe/tags/{id}/` - Partially update tag (authenticated)
- `DELETE /api/recipe/tags/{id}/` - Delete tag (authenticated)

**Query Parameters:**
- `assigned_only`: Filter by tags assigned to recipes (0 or 1)

### Ingredients

- `GET /api/recipe/ingredients/` - List all ingredients (authenticated)
- `POST /api/recipe/ingredients/` - Create a new ingredient (authenticated)
- `PUT /api/recipe/ingredients/{id}/` - Update ingredient (authenticated)
- `PATCH /api/recipe/ingredients/{id}/` - Partially update ingredient (authenticated)
- `DELETE /api/recipe/ingredients/{id}/` - Delete ingredient (authenticated)

**Query Parameters:**
- `assigned_only`: Filter by ingredients assigned to recipes (0 or 1)

### API Documentation

- `GET /api/schema/` - OpenAPI schema
- `GET /api/docs/` - Interactive Swagger UI documentation

## Authentication

The API uses token-based authentication. To authenticate:

1. Create a user account:
```bash
POST /api/user/create/
{
  "email": "user@example.com",
  "password": "yourpassword",
  "name": "Your Name"
}
```

2. Obtain an authentication token:
```bash
POST /api/user/token/
{
  "email": "user@example.com",
  "password": "yourpassword"
}
```

3. Include the token in subsequent requests:
```bash
Authorization: Token <your-token-here>
```

## Testing

Run the test suite:

```bash
cd app
python manage.py test
```

The project includes comprehensive tests for:
- User authentication and management
- Recipe CRUD operations
- Tag and ingredient management
- Image upload functionality
- Admin interface
- Custom management commands
- Model validations

## Project Structure

```
backend-recipe-api-app/
├── app/
│   ├── app/              # Django project settings
│   │   ├── settings.py
│   │   ├── urls.py
│   │   ├── wsgi.py
│   │   └── asgi.py
│   ├── core/             # Core app (User model, Recipe model)
│   │   ├── models.py
│   │   ├── admin.py
│   │   └── management/
│   │       └── commands/
│   │           └── wait_for_db.py
│   ├── recipe/           # Recipe app
│   │   ├── views.py
│   │   ├── serializers.py
│   │   ├── urls.py
│   │   └── tests/
│   ├── user/             # User app
│   │   ├── views.py
│   │   ├── serializers.py
│   │   ├── urls.py
│   │   └── tests/
│   └── manage.py
├── proxy/                # Nginx configuration
│   ├── Dockerfile
│   ├── default.conf.tpl
│   └── run.sh
├── scripts/              # Deployment scripts
│   └── run.sh
├── docker-compose.yml    # Development Docker Compose
├── docker-compose-deploy.yml  # Production Docker Compose
├── Dockerfile
├── requirements.txt
└── requirements.dev.txt
```

## Deployment

### Production Deployment

1. Update `.env` file with production settings:
```env
DEBUG=False
DJANGO_ALLOWED_HOSTS=your-domain.com
# ... other production settings
```

2. Build and run with production Docker Compose:
```bash
docker-compose -f docker-compose-deploy.yml up -d
```

The production setup includes:
- uWSGI with 4 workers
- Nginx reverse proxy
- Static file serving
- Persistent database volumes

### Environment-Specific Configuration

- **Development**: Uses `docker-compose.yml` with volume mounts for hot-reloading
- **Production**: Uses `docker-compose-deploy.yml` with optimized settings

## Database Management

The project includes a custom management command to wait for database availability:

```bash
python manage.py wait_for_db
```

This is useful in Docker environments where the database container may take time to start.

## Static and Media Files

- Static files are collected to `/vol/web/static`
- Media files (uploaded images) are stored in `/vol/web/media`
- Nginx serves static and media files in production

## License

This project is open source and available for personal and educational use.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

