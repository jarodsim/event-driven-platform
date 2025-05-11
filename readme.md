# Plataforma de Processamento Assíncrono com Arquitetura Orientada a Eventos ("Desafio" gerado por IA)

## 🎯 Objetivo

Criar uma arquitetura distribuída e resiliente baseada em eventos, com múltiplos serviços desacoplados que processam dados de forma assíncrona, utilizando os principais serviços da AWS e infraestrutura como código com Terraform.

---

## 🧱 Arquitetura Geral

```mermaid
flowchart TD
  A[API Gateway] --> B[Lambda Entrada]
  B --> C[EventBridge Bus]
  C --> D1[Lambda - Validação]
  C --> D2[Lambda - Faturamento]
  C --> D3[Lambda - Notificação]
  D1 -->|Falha| E1[DLQ - Validação]
  D2 -->|Falha| E2[DLQ - Faturamento]
  D3 -->|Falha| E3[DLQ - Notificação]
````

---

## 📦 Componentes

### 1. API Gateway

* Recebe requisições HTTP e envia para a primeira Lambda.

### 2. Lambda Entrada

* Valida entrada básica e publica evento no EventBridge.

### 3. EventBridge Bus

* Dispara eventos para os serviços consumidores com base em regras.

### 4. Serviços consumidores

* Lambda de Validação
* Lambda de Faturamento
* Lambda de Notificação

### 5. Dead Letter Queues (DLQs)

* Cada Lambda tem sua fila SQS de erro.

### 6. Observabilidade

* CloudWatch Logs e Métricas
* Alarmes em caso de falhas

---

## 🛠️ Tecnologias

* AWS Lambda
* AWS API Gateway
* AWS EventBridge
* AWS SQS (com DLQ)
* AWS CloudWatch (Logs)
* AWS IAM (roles por módulo)
* Terraform (modularizado)
* Python (para Lambdas)

---

## 🔄 Fluxo do Evento

1. Usuário faz requisição via API Gateway
2. Lambda de entrada valida e publica no EventBridge
3. Cada serviço recebe o evento e processa
4. Erros vão para DLQs
5. Logs e métricas são monitorados

---

## 📌 Extras (opcional)

* Implementar retries com backoff
* Expor um endpoint `/status` para consultar eventos recentes

