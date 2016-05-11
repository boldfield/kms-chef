#
# Cookbook Name:: kms
# Library:: provider_kms
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

require 'json'
require 'chef/provider'
require 'chef/resource/file'
require_relative 'kms_helpers'
require_relative 'resource_kms_file'

class Chef
  class Provider
    # A Chef provider for a Hipache configuration
    #
    # @author Brian Oldfield <brian@oldfield.io>
    class KmsFile < Provider
      include ::Kms::Helpers
      use_inline_resources

      #
      # Advertise WhyRun mode support
      #
      # @return [TrueClass, FalseClass]
      #
      def whyrun_supported?
        true
      end

      #
      # Load and return the current resource
      #
      # @return [Chef::Resource::Kms]
      #
      def load_current_resource
        @current_resource ||= Resource::Kms.new(new_resource.name)
      end

      def action_create
        require 'aws-sdk-resource'
        configure_sdk(new_resource)

        # key = s3_key(new_resource.source)
        # bucket = s3_bucket(new_resource.source)
      end

      def action_delete
      end
    end
  end
end
