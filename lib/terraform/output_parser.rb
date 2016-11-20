# frozen_string_literal: true

# Copyright 2016 New Context Services, Inc.
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

require 'json'

module Terraform
  # A parser for output command values
  class OutputParser
    def iterate_parsed_output(&block)
      Array(parsed_output)
        .each { |list_value| list_value.split(',').each(&block) }
    end

    def parsed_output
      ::JSON.parse(value).fetch 'value'
    rescue ::JSON::ParserError
      value
    end

    private

    attr_accessor :value

    def initialize(value:)
      self.value = value
    end
  end
end