# Multi-stage build для минимального размера образа
FROM nginx:1.25-alpine AS final

# Копируем кастомную страницу
COPY index.html /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Healthcheck для Kubernetes probes
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --quiet --tries=1 --spider http://localhost:8080/health || exit 1

EXPOSE 8080

# Запуск от непривилегированного пользователя (security best practice)
USER nginx
