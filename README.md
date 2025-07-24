# terraform-aws-3tier-ecs-architecture

- Complete Project Documentation
==========================================
# 🏗️ AWS 3-Tier Architecture with ECS & Terraform

A production-ready 3-tier web application architecture deployed on AWS using Terraform, featuring high availability, auto-scaling, and security best practices.

## 🎯 Project Overview

This project demonstrates a complete enterprise-grade 3-tier architecture:

- **Presentation Tier**: Application Load Balancer (ALB) with SSL termination
- **Application Tier**: ECS Fargate with auto-scaling and health checks  
- **Data Tier**: RDS MySQL with Multi-AZ deployment and encryption

## 🏛️ Architecture Diagram

```
Internet Gateway
       |
   [Application Load Balancer]
       |
   [ECS Fargate Tasks]
       |
   [RDS MySQL Multi-AZ]
```

## ✨ Key Features

- 🔒 **Security**: VPC with public/private subnets, security groups, IAM roles
- 🔄 **High Availability**: Multi-AZ deployment across 2+ availability zones
- 📈 **Auto Scaling**: ECS service scaling based on CPU/memory metrics
- 📊 **Monitoring**: CloudWatch logs, metrics, and Performance Insights
- 🔐 **Secrets Management**: AWS Systems Manager Parameter Store
- 💰 **Cost Optimized**: Fargate Spot, right-sized instances, log retention
- 📱 **Health Checks**: Application and infrastructure health monitoring

## 🛠️ Tech Stack

- **Infrastructure**: Terraform, AWS VPC, Security Groups
- **Compute**: ECS Fargate, Application Load Balancer
- **Database**: RDS MySQL 8.0 with Multi-AZ
- **Application**: Node.js, Express.js, MySQL2
- **Containerization**: Docker, Amazon ECR
- **Monitoring**: CloudWatch, Performance Insights
- **Security**: IAM, Parameter Store, Security Groups

## 📁 Project Structure

```
terraform-aws-3tier-ecs-architecture/
├── main.tf                 # Main Terraform configuration
├── variables.tf            # Input variables
├── outputs.tf             # Output values
├── terraform.tfvars.example # Example variables file
├── modules/               # Terraform modules
│   ├── vpc/              # VPC, subnets, routing
│   ├── alb/              # Application Load Balancer
│   ├── ecs/              # ECS cluster and service
│   └── rds/              # RDS database
├── app/                  # Sample Node.js application
│   ├── Dockerfile        # Container definition
│   ├── package.json      # Node.js dependencies
│   └── server.js         # Application code
├── scripts/              # Deployment scripts
│   ├── build-and-push.sh # Docker build and ECR push
│   └── deploy.sh         # Complete deployment
└── README.md             # This file
```

## 🚀 Quick Start

### Prerequisites
- AWS CLI configured with appropriate permissions
- Terraform >= 1.0
- Docker installed
- Git

### Step 1: Clone Repository
```bash
git clone https://github.com/yourusername/terraform-aws-3tier-ecs-architecture.git
cd terraform-aws-3tier-ecs-architecture
```

### Step 2: Configure Variables
```bash
cp terraform.tfvars.example terraform.tfvars
# Edit terraform.tfvars with your values
```

### Step 3: Deploy Infrastructure
```bash
# Make scripts executable
chmod +x scripts/*.sh

# Run complete deployment
./scripts/deploy.sh
```

### Step 4: Test Application
```bash
# Get application URL
terraform output alb_url

# Test endpoints
curl $(terraform output -raw alb_url)/health
curl $(terraform output -raw alb_url)/api/users
```

## 🔧 Manual Deployment Steps

If you prefer manual deployment:

```bash
# 1. Build and push Docker image
./scripts/build-and-push.sh

# 2. Initialize Terraform
terraform init

# 3. Plan deployment
terraform plan

# 4. Apply changes
terraform apply

# 5. Get outputs
terraform output
```

## 📊 Monitoring & Logging

- **CloudWatch Logs**: `/ecs/{project-name}`
- **Metrics**: ECS service, ALB, RDS metrics
- **Health Checks**: Application health endpoint at `/health`
- **Performance Insights**: RDS query performance monitoring

## 🔒 Security Features

- **Network Security**: Private subnets for app and database tiers
- **Access Control**: Security groups with least privilege
- **Encryption**: RDS encryption at rest and in transit
- **Secrets**: Database passwords stored in Parameter Store
- **IAM**: Least privilege roles for ECS tasks

## 💰 Cost Optimization

- **Right Sizing**: Optimized instance types and sizes
- **Auto Scaling**: Scale based on actual demand
- **Reserved Capacity**: Use reserved instances for predictable workloads
- **Log Retention**: 30-day CloudWatch log retention
- **Spot Instances**: Consider Fargate Spot for non-critical workloads

## 🧪 Testing

Test all application endpoints:

```bash
# Health check
curl https://your-alb-url/health

# Get users
curl https://your-alb-url/api/users

# Create user
curl -X POST https://your-alb-url/api/users \
  -H "Content-Type: application/json" \
  -d '{"name":"Test User","email":"test@example.com"}'

# Database status
curl https://your-alb-url/api/database-status
```

## 🔄 CI/CD Integration

This project is ready for CI/CD integration:

- **GitHub Actions**: Use the provided Terraform configurations
- **Jenkins**: Integrate with provided shell scripts
- **GitLab CI**: Adapt scripts for GitLab pipelines

## 🧹 Cleanup

To avoid AWS charges, destroy resources when done:

```bash
terraform destroy
```

## 📈 Scaling Considerations

- **Horizontal Scaling**: ECS auto-scaling configured
- **Database Scaling**: Consider read replicas for read-heavy workloads
- **CDN**: Add CloudFront for static content
- **Caching**: Implement ElastiCache for session/data caching

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/new-feature`
3. Commit changes: `git commit -am 'Add new feature'`
4. Push to branch: `git push origin feature/new-feature`
5. Submit a Pull Request
## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Author

**Jegan**
- Email: itsmejega.2010@gmail.com
- LinkedIn: [linkedin.com/in/jeganm29011995](https://linkedin.com/in/jeganm29011995)
- GitHub: [github.com/yourusername](https://github.com/yourusername)

## 🙏 Acknowledgments

- AWS Documentation and Best Practices
- Terraform AWS Provider Documentation
- Community feedback and contributions

---

⭐ **Star this repository if it helped you!**

📧 **Questions?** Feel free to open an issue or contact me directly.
