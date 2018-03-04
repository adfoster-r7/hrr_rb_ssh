# coding: utf-8
# vim: et ts=2 sw=2

require 'hrr_rb_ssh/logger'
require 'hrr_rb_ssh/message/codable'

module HrrRbSsh
  module Message
    module SSH_MSG_NEWKEYS
      class << self
        include Codable

        def definition
          DEFINITION
        end
      end

      ID    = self.name.split('::').last
      VALUE = 21

      DEFINITION = [
        # [Data Type, Field Name]
        ['byte',      'SSH_MSG_NEWKEYS'],
      ]
    end
  end
end
