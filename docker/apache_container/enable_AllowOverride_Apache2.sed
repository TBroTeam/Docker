        # find the corresponding entry for Directory
      /<Directory \/var\/www\/>/{

          # set a label get_next_line
          :get_next_line

          N

          # does the block contain a whole Directory block?
          s/<\/Directory>/<\/Directory>/

          # if no, jump to get_next_line
          T get_next_line
          # else substitute the AllowOverride option
          s/\(^.*AllowOverride \)[^\n]*/\1 All/

      }
