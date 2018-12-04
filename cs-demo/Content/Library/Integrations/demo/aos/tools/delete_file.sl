namespace: Integrations.demo.aos.tools
flow:
  name: delete_file
  inputs:
    - host: 10.0.46.48
    - username: root
    - password: admin@123
    - filename: deploy_war.sh
  workflow:
    - delete_file:
        do:
          io.cloudslang.base.ssh.ssh_command:
            - host: '${host}'
            - command: "${'cd '+get_sp('script_location')+' && rm -f '+filename}"
            - username: '${username}'
            - password:
                value: '${password}'
                sensitive: true
        navigate:
          - SUCCESS: SUCCESS
          - FAILURE: on_failure
  results:
    - SUCCESS
    - FAILURE
extensions:
  graph:
    steps:
      delete_file:
        x: 204
        y: 137
        navigate:
          11e966b5-40c7-da92-8edc-2e3f0a86ea7a:
            targetId: 01f99f99-3e41-5125-10de-3ef9b11d0df0
            port: SUCCESS
    results:
      SUCCESS:
        01f99f99-3e41-5125-10de-3ef9b11d0df0:
          x: 420
          y: 141
