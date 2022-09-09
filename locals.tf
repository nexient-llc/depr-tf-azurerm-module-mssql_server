# Copyright 2022 Nexient LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

locals {
  default_tags = {
    provisioner = "Terraform"
  }

  tags = merge(local.default_tags, var.custom_tags)

  # Variables related to the firewall rules

  azure_services_firewall_rule = var.allowAccessToAzureServices ? [{
    start_ip_address = "0.0.0.0"
    end_ip_address   = "0.0.0.0"
  }] : []

  allowFirewallIpList = [for ip_address in var.allowFirewallIpList : {
    start_ip_address = ip_address
    end_ip_address   = ip_address
  }]

  all_firewall_rules = concat(local.azure_services_firewall_rule, local.allowFirewallIpList, var.allowFirewallIpRangesList)
}
