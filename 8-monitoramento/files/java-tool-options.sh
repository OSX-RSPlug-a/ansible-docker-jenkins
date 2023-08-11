#!/bin/sh
# possibilita a exportação de métricas da JVM para o Prometheus
export JAVA_TOOL_OPTIONS=-javaagent:/usr/share/java/jmx_prometheus_javaagent-0.15.0.jar=9010:/etc/jmx_exporter/config.yaml