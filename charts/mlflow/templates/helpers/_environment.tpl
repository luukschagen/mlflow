{{/* Get the default artifact root */}}
{{- define "mlflow.artifactDestination" -}}
{{- if .Values.artifacts.s3.artifactDestination -}}
- name: ARTIFACT_DESTINATION
  value: {{ .Values.artifacts.s3.artifactDestination }}
{{- else if .Values.artifacts.gcp.artifactDestination -}}
- name: ARTIFACT_DESTINATION
  value: {{ .Values.artifacts.gcp.artifactDestination }}
{{- else if .Values.artifacts.azure.artifactDestination -}}
- name: ARTIFACT_DESTINATION
  value: {{ .Values.artifacts.azure.artifactDestination }}
{{- else -}}
{{  fail "Could not resolve `default artifact root` from supplied values" }}
{{- end -}}
{{- end -}}


{{/* Get the backend store uri */}}
{{- define "mlflow.backendStoreUri" -}}
{{- if .Values.backendStore.existingSecret -}}
- name: BACKEND_STORE_URI
  valueFrom:
    secretKeyRef:
      name: {{ .Values.backendStore.existingSecret }}
      key: BACKEND_STORE_URI
      optional: false
{{- else if .Values.backendStore.createSecret.uri -}}
- name: BACKEND_STORE_URI
  valueFrom:
    secretKeyRef:
      name: mlflow-backend-store-credentials
      key: BACKEND_STORE_URI
      optional: false
{{- else -}}
{{  fail "Could not resolve `backend store uri` from supplied values" }}
{{- end -}}
{{- end -}}
