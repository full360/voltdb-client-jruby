module Voltdb
  module VoltTableRowUtils

    # Get a long value from a VoltTableRow as a boolean value
    #
    # @param column_index_or_name [Fixnum, String]
    # @return [Boolean]
    def get_long_as_boolean(column_index_or_name)
      self.get_long(column_index_or_name) == 1
    end

    # Get the value of the column or nil
    #
    # @param column_index_or_name [Fixnum, String]
    # @return [VoltType, Boolean]
    def get_long_or_nil(column_index_or_name)
      value = self.get_long(column_index_or_name)

      self.was_null? ? nil : value
    end

    # Get a Ruby DateTime from a VoltTableRow timestamp type value
    #
    # @param column_index_or_name [Fixnum, String]
    # @return [DateTime]
    def get_timestamp_as_ruby_date_time(column_index_or_name)
      timestamp = get_timestamp_for_ruby(column_index_or_name)

      timestamp ? DateTime.parse(timestamp.to_s) : timestamp
    end

    # Get a Ruby Date from a VoltTableRow timestamp type value
    #
    # @param column_index_or_name [Fixnum, String]
    # @return [Date]
    def get_timestamp_as_ruby_date(column_index_or_name)
      timestamp = get_timestamp_for_ruby(column_index_or_name)

      timestamp ? Date.parse(timestamp.to_s) : timestamp
    end

    # Get a Ruby Time from a VoltTableRow timestamp type value
    #
    # @param column_index_or_name [Fixnum, String]
    # @return [Time]
    def get_timestamp_as_ruby_time(column_index_or_name)
      timestamp = get_timestamp_for_ruby(column_index_or_name)

      timestamp ? Time.parse(timestamp.to_s) : timestamp
    end

    private

    def get_timestamp_for_ruby(column_index_or_name)
      self.get_timestamp_as_sql_timestamp(column_index_or_name)
    end
  end
end
