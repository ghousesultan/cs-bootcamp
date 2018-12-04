namespace: Integrations.demo.aos.tools
flow:
  name: install_aos
  inputs:
    - username: "${get_sp('vm_username')}"
    - password: "${get_sp('vm_password')}"
    - tomcat_host
    - account_service_host
    - db_host
  results: []
