#!/bin/bash

# Complete deployment script

set -e

echo "🚀 Starting 3-Tier ECS Architecture Deployment"

# Check prerequisites
command -v terraform >/dev/null 2>&1 || { echo "Terraform is required but not installed. Aborting." >&2; exit 1; }
command -v aws >/dev/null 2>&1 || { echo "AWS CLI is required but not installed. Aborting." >&2; exit 1; }
command -v docker >/dev/null 2>&1 || { echo "Docker is required but not installed. Aborting." >&2; exit 1; }

# Check if terraform.tfvars exists
if [ ! -f "terraform.tfvars" ]; then
    echo "⚠️  terraform.tfvars not found. Please copy terraform.tfvars.example and update values."
    exit 1
fi

# Build and push Docker image
echo "📦 Building and pushing Docker image..."
./scripts/build-and-push.sh

# Initialize Terraform
echo "🔧 Initializing Terraform..."
terraform init

# Plan deployment
echo "📋 Planning Terraform deployment..."
terraform plan -out=tfplan

# Apply deployment
echo "🚀 Applying Terraform deployment..."
terraform apply tfplan

# Get outputs
echo "✅ Deployment completed successfully!"
echo ""
echo "📊 Deployment Information:"
terraform output

echo ""
echo "🌐 Your application will be available at:"
terraform output -raw alb_url

echo ""
echo "📝 Next steps:"
echo "1. Wait 2-3 minutes for the ECS service to start"
echo "2. Test the application endpoints:"
echo "   - Health check: $(terraform output -raw alb_url)/health"
echo "   - API users: $(terraform output -raw alb_url)/api/users"
echo "3. Monitor logs in CloudWatch: /ecs/$(terraform output -raw ecs_cluster_name | cut -d'-' -f1-3)"

# Clean up plan file
rm -f tfplan

# .gitignore
# Terraform
*.tfstate
*.tfstate.*
*.tfvars
!terraform.tfvars.example
.terraform/
.terraform.lock.hcl
tfplan
*.tfplan

# IDE
.vscode/
.idea/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db

# Logs
*.log
logs/

# Node.js
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Docker
.dockerignore

# Environment
.env
.env.local
.env.*.local

# Backup files
*.backup
*.bak
