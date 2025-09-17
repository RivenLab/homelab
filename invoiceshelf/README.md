# MY NOTES

# Docker named volume for storage 

Instead of mounting a host path, you can let Docker manage the storage location via a **named volume** (reduces host-permission issues).

**Old compose (host bind mounts):**
```yaml
volumes:
  - ./invoiceshelf_sqlite/data:/data
  - ./invoiceshelf_sqlite/conf:/conf
```

**New compose (Docker named volume):**
```yaml
services:
  webapp:
    volumes:
      - invoiceshelf_storage:/var/www/html/storage

volumes:
  invoiceshelf_storage:
```

If you want to **migrate existing storage** into the named volume:

1) Create and inspect the volume:
```bash
docker volume create {compose_project}_invoiceshelf_storage
docker volume inspect {compose_project}_invoiceshelf_storage
```

Where `{compose_project}` is the name of your directory where the docker compose is located. If you cloned this repository it will be `docker`.


# Customisation
To create a invoice or estimate template 
```bash
docker exec -it invoiceshelf php artisan make:template <template-name>
```
the original templates are in the folder `./resources/views/app/pdf/invoice/`
```
invoice1.blade.php
invoice2.blade.php
invoice3.blade.php
```