variable "bucket_name" {
  type        = string
  description = "Nom unique du bucket S3"
}

variable "tags" {
  type        = map(string)
  description = "Tags à associer au bucket S3"
  default     = {}
}
