module Voltdb
  module VoltTableUtils
    java_import Java::OrgVoltdb::VoltTable
    java_import Java::OrgVoltdb::VoltTableRow

    # Persist VoltTable to avoid the warning when we duplicate the object to
    # extend it
    Java::OrgVoltdb::VoltTable.__persistent__ = true

    # This method is used when we extend the VoltDB VoltTable interface and
    # it's used to iterate over a VoltTableRow while also adding VoltTableRow
    # Ruby Utils
    #
    # @param volt_table [VoltTable]
    # @yield [VoltTableRow]
    # @return [Array<Object, Object>]
    def self.map_volt_table(volt_table, &block)
      results = []

      volt_table.reset_row_position
      volt_table.extend(VoltTableRowUtils)

      while(volt_table.advance_row) do
        results << block.call(volt_table)
      end

      results
    end

    # This method is used when we extend the VoltDB VoltTable interface and
    # it's used to iterate over the first row of a VoltTableRow while also
    # adding VoltTableRow Ruby Utils
    #
    # @param volt_table [VoltTable]
    # @yield [VoltTableRow]
    # @return [Object, nil]
    def self.map_first_row_from_volt_table(volt_table, &block)
      volt_table.reset_row_position
      volt_table.extend(VoltTableRowUtils)

      if(volt_table.advance_row)
        block.call(volt_table)
      else
        nil
      end
    end

    # This method is used when we extend the VoltDB VoltTable interface and
    # it's used to iterate over a VoltTableRow while also adding VoltTableRow
    # Ruby Utils
    #
    # @yield [VoltTableRow]
    # @return [Array<Object, Object>]
    def map
      VoltTableUtils.map_volt_table(self, &block)
    end

    # This method is used when we extend the VoltDB VoltTable interface and
    # it's used to iterate over the first row of a VoltTableRow while also
    # adding VoltTableRow Ruby Utils
    #
    # @yield [VoltTableRow]
    # @return [Object, nil]
    def map_first_row
      VoltTableUtils.map_first_row_from_volt_table(self, &block)
    end
  end
end
