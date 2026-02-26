data "template_file" "cloudinit" {
  template = file("${path.module}/init.cfg")
}

data "template_cloudinit_config" "intall-apache-config" {
    gzip = true
    base64_encode = false

    part {
      filename = "init.cfg"
      content_type = "text/could-config"
      content = data.template_file.cloudinit.rendered
       }
}