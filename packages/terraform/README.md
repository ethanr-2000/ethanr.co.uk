# Terraform

## Useful Commands

#### Boostrap
  ```
  packages/terraform/bin/terraform.sh -r eu-west-2 -p er --bootstrap -a apply
  ```

#### Plan
  ```
  packages/terraform/bin/terraform.sh -t -r eu-west-2 -p er -g main -e prod -c ethanr -a plan
  ```

#### Apply
  ```
  packages/terraform/bin/terraform.sh -t -r eu-west-2 -p er -g main -e prod -c ethanr -a apply
  ```
