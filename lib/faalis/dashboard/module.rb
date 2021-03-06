# -----------------------------------------------------------------------------
#    Faalis - Basic website skel engine
#    Copyright (C) 2012-2013 Yellowen
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License along
#    with this program; if not, write to the Free Software Foundation, Inc.,
#    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
# -----------------------------------------------------------------------------

module Faalis
  class Dashboard
    module Module

      @@priority = 50
      @@name = "default_name"
      # Register the module on given section with given priority
      def self.show_me_on(section, priority = nil)
        Faalis::Dashboard.instance.register_module(section, self)
        if not priority.nil?
          @@priority = priority
        end
      end

      def self.priority(priority_)
        @@priority = priority_.to_i
      end

      def self.name(name_)
        @@name = name_.to_s
      end


    end
  end
end
