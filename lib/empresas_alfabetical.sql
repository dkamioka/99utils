SELECT name, created_at FROM companies WHERE deleted_at is null ORDER BY name ASC;
