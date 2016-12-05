require 'togglv8'
require "togglapper/client_module"
module Togglapper
  module Searches
    module Base

      # entry = toggl の個タスク
      # APIの持ち主の entry 一覧を取得する
      # ex: entryの中身
      # {
      #  "id"=>491600812,
      #  "wid"=>1552948,
      #  "billable"=>false,
      #  "start"=>"2016-12-01T15:42:21+00:00",
      #  "stop"=>"2016-12-01T15:42:53+00:00",
      #  "duration"=>32,
      #  "description"=>"aaa",
      #  "tags"=>["#2661"],
      #  "duronly"=>false,
      #  "at"=>"2016-12-01T15:42:53+00:00",
      #  "uid"=>2344433},
      # }
      def entries(refresh: false)
        if refresh
          @entries = client.my_time_entries
        else
          @entries ||= client.my_time_entries
        end
      end

      def latest_entry
        entries.sort_by{ |entry| entry["start"] }.last
      end

      def working_entry
        if latest_entry["stop"].nil?
          latest_entry
        end
      end

      # entry 情報からその entry にどれだけの時間を使ったか返す。
      # 返すのは基本的にUnix 秒。ただし format を指定すれば時間や分の単位で返す。
      def get_diff_time_by_entry(entry = latest_entry, format = nil)
        if entry["duration"] && entry["stop"]
          diff_time = entry["duration"]
        else
          # 現在作業中（終了時間がない）であれば現在日時を終了時間として取得
          stop_time_org  = Time.now

          # 差分の時間数を計算
          start_time = Time.parse(entry["start"]).getlocal("+09:00")
          stop_time  = stop_time_org.getlocal("+09:00")
          diff_time  = stop_time - start_time
        end

        if format.nil?
          diff_time.to_i
        elsif format == '%H' || format == '%h'
          diff_time/3600
        elsif format == '%M' || format == '%m'
          diff_time/60
        elsif format == '%S' || format == '%s'
          diff_time.to_i
        else
          raise 'invalid format: #{format}. exsample: %H(h), %M(m), %S(s)'
        end
      end

      # entry 情報から「タグ情報」「説明文（Description)」「タスク実績時間」を取得する
      def entry_info(entry = latest_entry)
        work_time = get_diff_time_by_entry(entry, '%S')
        tags = entry["tags"] || nil
        description = entry["description"] || nil

        { description: description, tags: tags, work_time: work_time }
      end

      # entry info の String Version
      def entry_info_string(entry = latest_entry)
        diff_time = get_diff_time_by_entry(entry, '%H')

        # 差分時間が 0.1h 以下の表示になるようであれば 分表示に変更する
        if diff_time >= 0.1
          work_time = "#{diff_time.round(2)}h"
        else
          work_time = "#{(diff_time * 60).round(2)}m"
        end

        tag = entry["tags"].join(" ") unless entry["tags"].nil?
        description = entry["description"]

        "#{tag} #{description} \(#{work_time}\)"
      end
    end
  end
end
