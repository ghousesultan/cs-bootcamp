namespace: Integrations.demo.aos.sub_flows
flow:
  name: deploy_wars
  inputs:
    - tomcat_host
    - account_service_host
    - db_host
    - username
    - password
    - url
  workflow:
    - deploy_account_service:
        do:
          Integrations.demo.aos.sub_flows.initialize_artifact:
            - host: '${account_service_host}'
            - username: '${username}'
            - artifact_url: "${url+'accountservice/target/accountservice.war'}"
            - script_url: deploy_war.sh
            - parameters: "db_host+' postgres admin '+tomcat_host+' '+account_service_host"
        navigate:
          - FAILURE: on_failure
          - SUCCESS: deploy_tm_wars
    - deploy_tm_wars:
        loop:
          for: "war in 'catalog','MasterCredit','order','ROOT','ShipEx','SafePay'"
          do:
            Integrations.demo.aos.sub_flows.initialize_artifact:
              - host: '${tomcat_host}'
              - username: '${username}'
              - password: '${password}'
              - artifact_url: "${url+war.lower()+'/target/'+war+'.war'}"
              - parameters: "db_host+' postgres admin '+tomcat_host+' '+account_service_host"
          break:
            - FAILURE
        navigate:
          - FAILURE: on_failure
          - SUCCESS: SUCCESS
  results:
    - FAILURE
    - SUCCESS
extensions:
  graph:
    steps:
      deploy_account_service:
        x: 263
        y: 116
      deploy_tm_wars:
        x: 483
        y: 114
        navigate:
          e239225d-8c7b-9528-b83e-840950889e1a:
            targetId: abeeb321-5b54-fdf4-607c-7bcdba3f8deb
            port: SUCCESS
    results:
      SUCCESS:
        abeeb321-5b54-fdf4-607c-7bcdba3f8deb:
          x: 662
          y: 124
