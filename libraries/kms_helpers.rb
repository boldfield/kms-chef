#
# Cookbook Name:: kms
# Library:: kms_helpers
#
# Copyright 2016, Brian Oldfield
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
require 'uri'

module Kms
  # A set of helper methods shared by all the resources and providers
  #
  # @author Brian Oldfield <brian@oldfield.io>
  module Helpers
    def self.s3_key(uri)
      msg = "KMS resource source must be defined as 's3://<bucket>/<path>'"
      raise(ArgumentError, msg) unless uri.start_with?('s3://')
      URI.parse(uri).path.reverse.chomp('/').reverse
    end

    def self.s3_bucket(uri)
      msg = "KMS resource source must be defined as 's3://<bucket>/<path>'"
      raise(ArgumentError, msg) unless uri.start_with?('s3://')
      URI.parse(uri).host
    end

    def self.configure_sdk(resource, config = {})
      config.merge!(
        region: resource.region,
        access_key_id: resource.access_key_id,
        secret_access_key: resource.secret_access_key
      )
      raise(ArgumentError, 'Region must be specified!') if config[:region].nil?
      config.each { |opt, value| ::Aws.config[opt] = value }
    end
  end
end
