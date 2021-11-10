json.title @diag.to_s
json.number_of_requests @diag.number_of_requests
json.total_byte_weight @diag.total_byte_weight
json.co2 @diag.co2
json.status @diag.status
json.attempts @diag.attempts
json.lighthouse do
  json.performance @diag.lighthouse_performance
  json.accessibility @diag.lighthouse_accessibility
  json.seo @diag.lighthouse_seo
  json.best_practices @diag.lighthouse_best_practices
end
