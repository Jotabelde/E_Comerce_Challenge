# 📦 E-commerce Database Model

Este repositório contém o modelo relacional de um banco de dados para um sistema de e-commerce, desenvolvido utilizando MySQL. O projeto inclui o script SQL para criação completa das tabelas, relacionamentos e regras de integridade.

---

## 📁 Conteúdo

- `modelo.mwb` – Modelo visual feito no MySQL Workbench
- `script.sql` – Script completo para criação das tabelas e constraints

---

## 🧱 Estrutura do Banco

### 🔹 Entidades principais

- **Customer**: Representa o cliente (pessoa física ou jurídica).
- **Product**: Produtos disponíveis para venda.
- **Order**: Pedidos feitos pelos clientes, com forma de pagamento.
- **Delivery**: Informações de entrega ligadas ao pedido.
- **Supplier**: Fornecedores dos produtos.
- **Stock**: Estoques físicos.

### 🔗 Tabelas de relacionamento

- **Order_has_Product**: Itens de cada pedido (N:N)
- **Stock_has_Product**: Produtos armazenados em cada estoque (N:N)
- **Supplier_supplies_Product**: Produtos fornecidos por cada fornecedor (N:N)

---

## 🛠️ Lógicas e Regras

- Clientes podem ser **Pessoa Física** ou **Jurídica**, com validação por `CPF` ou `CNPJ` via `CHECK`.
- Pedidos aceitam os métodos: `Credit_Card`, `Pix`, `Boleto` ou `Cash`.
  - Se o pagamento for via `Pix`, o campo `payment_reference` deve ser preenchido.
- Toda **entrega** está ligada a um único pedido e possui status, endereço, código de rastreio e valor do frete (que pode ser nulo).
- A integridade referencial é garantida por chaves estrangeiras entre as entidades.

---

## 🚀 Como usar

1. Abra o arquivo `modelo.mwb` no MySQL Workbench para visualizar o modelo.
2. Execute o `script.sql` em um banco de dados MySQL para criar as tabelas.
   - Ele já inclui desativação temporária de restrições para facilitar a execução.
3. O schema será criado com o nome `E_comerce`.

---

## 📌 Observações

- Charset utilizado: `utf8mb4`, para garantir suporte a caracteres especiais.
- Todas as tabelas usam o mecanismo `InnoDB`, ideal para integridade transacional.
- O nome do schema segue a convenção `E_comerce` (com _).

---

## 📄 Licença

Este projeto é livre para fins acadêmicos e de aprendizado.

---
