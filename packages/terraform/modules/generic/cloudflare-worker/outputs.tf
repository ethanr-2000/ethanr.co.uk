output "script_name" {
  value = cloudflare_workers_script.main.script_name
}

output "url" {
  value = var.hostname != null ? "https://${var.hostname}" : null
}
