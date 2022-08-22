cd
echo --- Packing repositories
zip --exclude '*/node_modules/*' --exclude '*/deploy/*' -r3qdgds 10m Backup/Repositories\ $(date +%Y%m%d).zip Dev/Repositories
echo --- Packing Documents folder
zip -ur0qdgds 10m Backup/Documents.zip Documents
echo --- Packing Backup folder
zip -ur0qdgds 10m Backup.zip Backup

