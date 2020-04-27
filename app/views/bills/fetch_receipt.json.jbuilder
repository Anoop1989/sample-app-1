
json.data do
  json.billerBillID @receipt.bill_id
  json.platformBillID @receipt.platform_bill_id
  json.platformTransactionRefID @receipt.service_provider_transaction_id
  json.receipt do
    json.date @receipt.generated_at.iso8601
    json.id @receipt.id
  end
end
