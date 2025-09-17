# MY NOTES

# Docker named volume for storage 

Instead of mounting a host path, you can let Docker manage the storage location via a **named volume** (reduces host-permission issues).

**(Docker named volume):**
```yaml
services:
  webapp:
    volumes:
      - invoiceshelf_storage:/var/www/html/storage

volumes:
  invoiceshelf_storage:
```

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