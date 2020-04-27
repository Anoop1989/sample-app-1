
json.data do
  json.billDetails do
    json.bills do
      json.array! @payer.bills, partial: 'bills/bill', as: :bill
    end
  end

  json.customer do
    json.name @payer.full_name
    json.additionalInfo @payer.slice(:id, :mobile_number)
  end
end
