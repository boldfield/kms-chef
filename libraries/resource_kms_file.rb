#
# Cookbook Name:: kms
# Library:: resource_kms
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

require 'chef/resource'
require_relative 'kms_helpers'
require_relative 'provider_kms_file'

class Chef
  class Resource
    # A Chef resource for resources encrypted with KMS
    #
    # @author Jonathan Hartman <j@p4nt5.com>
    class KmsFile < Resource
      include ::Kms::Helpers

      attr_accessor :created
      alias created? created

      def initialize(name, run_context = nil)
        super
        @resource_name = :kms_file
        @provider = Chef::Provider::KmsFile
        @action = [:create]
        @allowed_actions = [:create, :delete]

        @created = false
      end

      #
      # The S3 URI at which the KMS resource is located
      #    s3://<bucket>/<path>
      #
      # @param [String, NilClass]
      # @return String
      #
      def source(arg = nil)
        set_or_return(:source, arg, kind_of: String)
      end

      #
      # The ARN of the KMS encryption key used to encrypt the data,
      # if omitted, unencrypted data assumed
      #
      # @param [String, NilClass]
      # @return String
      #
      def kms_arn(arg = nil)
        set_or_return(:kms_arn, arg, kind_of: String)
      end

      #
      # The S3 bucket in which the target file lives
      #
      # @param [String, NilClass]
      # @return String
      #
      def region(arg = nil)
        set_or_return(:region, arg, kind_of: String)
      end

      #
      # AWS Access Key ID to use, leave nil to utilize instance profiles
      #
      # @param [String, NilClass]
      # @return String
      #
      def access_key_id(arg = nil)
        set_or_return(:access_key_id, arg, kind_of: String)
      end

      #
      # AWS Access Key ID to use, leave nil to utilize instance profiles
      #
      # @param [String, NilClass]
      # @return String
      #
      def secret_access_key(arg = nil)
        set_or_return(:secret_access_key, arg, kind_of: String)
      end

      #
      # Additional configuration for Aws clients
      #
      # @param [Hash, NilClass]
      # @return Hash
      #
      def aws_config(arg = nil)
        set_or_return(:secret_access_key, arg, kind_of: Hash, default: {})
      end
    end
  end
end
