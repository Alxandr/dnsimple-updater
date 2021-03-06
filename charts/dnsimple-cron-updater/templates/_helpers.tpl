{{/*
Expand the name of the chart.
*/}}
{{- define "dnsimple-cron-updater.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "dnsimple-cron-updater.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "dnsimple-cron-updater.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "dnsimple-cron-updater.labels" -}}
helm.sh/chart: {{ include "dnsimple-cron-updater.chart" . }}
{{ include "dnsimple-cron-updater.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "dnsimple-cron-updater.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dnsimple-cron-updater.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the secret to use
*/}}
{{- define "dnsimple-cron-updater.secretName" -}}
{{- if .Values.dnsimple.existingSecret }}
{{- .Values.dnsimple.existingSecret }}
{{- else }}
{{- if .Values.secretnameOverride }}
{{- .Values.secretnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- include "dnsimple-cron-updater.fullname" . }}
{{- end }}
{{- end }}
{{- end }}
