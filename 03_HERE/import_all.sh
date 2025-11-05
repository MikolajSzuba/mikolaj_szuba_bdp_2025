#!/bin/bash

SHP_DIR="03_shapes/shp/Karlsruhe_Germany_Shapefile"
SCHEMA="karlsruhe"
DB_CONTAINER="postgres_bdp"
DB_USER="postgres"
DB_NAME="postgres"
CONTAINER_SHP_DIR="/tmp/karlsruhe_shp"

echo "Starting shapefile import for Karlsruhe data..."
echo "================================================"

# Step 1: Copy shapefiles to container
echo "Copying shapefiles to Docker container..."
docker exec ${DB_CONTAINER} mkdir -p ${CONTAINER_SHP_DIR}
docker cp ${SHP_DIR}/. ${DB_CONTAINER}:${CONTAINER_SHP_DIR}/
echo "✓ Shapefiles copied to container"
echo ""

# Step 2: Install shp2pgsql in container if not present
echo "Checking for shp2pgsql in container..."
docker exec ${DB_CONTAINER} bash -c "
    if ! command -v shp2pgsql &> /dev/null; then
        echo 'Installing PostGIS tools...'
        apt-get update -qq && apt-get install -y -qq postgis > /dev/null 2>&1
        echo '✓ PostGIS tools installed'
    else
        echo '✓ shp2pgsql already available'
    fi
"
echo ""

# Function to import shapefile from within container
import_shapefile() {
    local year=$1
    local filename=$2
    local tablename=$(echo "${year}_${filename}" | tr '[:upper:]' '[:lower:]')
    
    echo "Importing ${filename} from ${year}..."
    docker exec ${DB_CONTAINER} bash -c "
        cd ${CONTAINER_SHP_DIR}/${year}_KAR_GERMANY && \
        shp2pgsql -I -s 4326 ${year}_${filename}.shp ${SCHEMA}.${tablename} | \
        psql -U ${DB_USER} -d ${DB_NAME} > /dev/null 2>&1
    "
    
    if [ $? -eq 0 ]; then
        echo "✓ ${filename} imported successfully as ${tablename}"
    else
        echo "✗ Failed to import ${filename}"
    fi
    echo ""
}

# Create schema
echo "Creating schema ${SCHEMA}..."
docker exec ${DB_CONTAINER} psql -U ${DB_USER} -d ${DB_NAME} -c "CREATE SCHEMA IF NOT EXISTS ${SCHEMA};"
echo ""

# Import 2018 data
echo "=== Importing 2018 data ==="
import_shapefile "T2018" "KAR_BUILDINGS"
import_shapefile "T2018" "KAR_POI_TABLE"

# Import 2019 data
echo "=== Importing 2019 data ==="
import_shapefile "T2019" "KAR_BUILDINGS"
import_shapefile "T2019" "KAR_POI_TABLE"
import_shapefile "T2019" "KAR_STREETS"
import_shapefile "T2019" "KAR_STREET_NODE"
import_shapefile "T2019" "KAR_LAND_USE_A"
import_shapefile "T2019" "KAR_RAILWAYS"
import_shapefile "T2019" "KAR_WATER_LINES"

# Cleanup
echo "Cleaning up temporary files..."
docker exec ${DB_CONTAINER} rm -rf ${CONTAINER_SHP_DIR}
echo "✓ Cleanup completed"
echo ""

echo "================================================"
echo "Import completed!"