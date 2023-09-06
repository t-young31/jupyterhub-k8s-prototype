locals {
  app_name = "app-oauth-jupyter-${var.suffix}"

  required_graph_permissions = [
    "Group.Read.All"
  ]
}
