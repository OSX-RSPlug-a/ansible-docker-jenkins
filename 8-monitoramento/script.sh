# passos

# 1. executar ansible passos anteriores

# 2. fazer deploy das stacks no WebFeeder

# on WSO2

# 2.1 deploy de stacks

# variáveis globais
export DOMAIN='cadastrodigital.testetech.com' # domain
export MANAGEMENT_DOMAIN='wso2-cadastrodigital.testetech.com' #wso2 domain
export PROXY_IP='10.1.7.4' # manager-ip
export ENVIRONMENT=degustacao #environment_name
export WSO2_IP='10.1.7.8' #wso2_ip
export BUILD_ID=1
export VERSION=1

# configurações do filebeats
export ELASTICSEARCH_HOST='elasticsearch'
export KIBANA_HOST='kibana'
export ELASTICSEARCH_USERNAME='elastic'
export ELASTICSEARCH_PASSWORD='yDqKlNVbVJipGuTYsM3F' # elk_password
export SERVICE_INDEX_NAME='wso2'

# pré-deploy

envsubst < /var/teste/wso2/stacks/elk/filebeat/config/filebeat.tmp.yml > /var/teste/wso2/stacks/elk/filebeat/config/filebeat.yml

# execução do deploy das stacks


docker stack deploy -c /var/teste/wso2/stacks/elk/docker-compose.yml elk

# 3 configurar JMX exporter

# instalação do JAR

sudo yum install wget -y
sudo -p /usr/share/java
wget https://repo1.maven.org/maven2/io/prometheus/jmx/jmx_prometheus_javaagent/0.15.0/jmx_prometheus_javaagent-0.15.0.jar -O /usr/share/java/jmx_prometheus_javaagent-0.15.0.jar

# cópia de config do JMX

sudo -p /etc/jmx_exporter
sudo mv /var/teste/wso2/jmx/jmx_exporter_config.yaml /etc/jmx_exporter/jmx/jmx_exporter_config.yaml

# config variável de ambiente JAVA_TOOL_OPTIONS

sudo mv ./jdk.sh /etc/profile.d/jdk.sh
sudo mv ./java-tool-otpions.sh /etc/profile.d/java-tool-otpions.sh

# carregar variáveis de ambiente
source /etc/profile.d/java-tool-otpions.sh
source /etc/profile.d/jdk.sh


# 4 configurar Filebeat

# configurar /etc/filebeat
# configurar /etc/hosts

# configurar repo do filebeat
sudo rpm --import https://packages.elastic.co/GPG-KEY-elasticsearch
sudo mv ./java-tool-otpions.sh /etc/profile.d/java-tool-otpions.sh

# instalação do Filebeat
sudo yum install filebeat-7.3.2

# cópia do arquivo de config


# configurar service do filebeat

# ativar service do filebeat
sudo systemctl enable filebeat
sudo systemctl start filebeat

# restartar WebFeeder
sudo systemctl stop wso2
sudo systemctl start wso2
