{{/*
Expand the name of the chart.
*/}}
{{- define "gitops-agent.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "gitops-agent.fullname" -}}
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
{{- define "gitops-agent.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "gitops-agent.labels" -}}
helm.sh/chart: {{ include "gitops-agent.chart" . }}
{{ include "gitops-agent.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "gitops-agent.selectorLabels" -}}
app.kubernetes.io/name: {{ include "gitops-agent.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "gitops-agent.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "gitops-agent.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Generate correct manager URLs for SMP or take SaaS defaults
*/}}
{{- define "gitops-agent.agentHttpTarget" -}}
{{- if .Values.harness.smpManagerURL -}}
{{ .Values.harness.smpManagerURL }}/gitops
{{- else -}}
{{ .Values.harness.agent.httpTarget }}
{{- end }}
{{- end }}

{{- define "gitops-agent.agentGrpcTarget" -}}
{{- if .Values.harness.smpManagerURL -}}
{{ .Values.harness.smpManagerURL }}:443
{{- else -}}
{{ .Values.harness.agent.grpcTarget }}
{{- end }}
{{- end }}

{{- define "gitops-agent.agentGrpcAuthority" -}}
{{- if .Values.harness.smpManagerURL -}}
{{ .Values.harness.smpManagerURL }}
{{- else -}}
{{ .Values.harness.agent.grpcAuthority }}
{{- end }}
{{- end }}
