#!/usr/bin/env ruby

require 'json'

module LT
  module Ansible
    def self.local_inventory
      {
        :"_meta" => {
          :hostvars => {
            :core01 => {
              ansible_ssh_host: "10.10.10.11",
              ansible_python_interpreter: "PATH=/home/core/bin:$PATH python"
            },
            :core02 => {
              ansible_ssh_host: "10.10.10.12",
              ansible_python_interpreter: "PATH=/home/core/bin:$PATH python"
            },
            :core03 => {
              ansible_ssh_host: "10.10.10.13",
              ansible_python_interpreter: "PATH=/home/core/bin:$PATH python"
            }
          }
        },
        :core => {
          :hosts => ["core01", "core02", "core03"]
        }
      }
    end
  end
end

puts LT::Ansible::local_inventory.to_json
