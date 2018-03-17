module InstancesHelper
  def abort_button(instance)
    if instance.present?
      case instance.state
        when "in_progress"
          link_to('放棄任務', abort_instance_path, method: :post, class: "btn btn-danger btn-sm", data: { confirm: "跟隊友溝通過了嗎，確定要放棄任務？" })
        when "teaming"
          link_to('放棄組隊', abort_instance_path, method: :post, class: "btn btn-danger btn-sm", data: { confirm: "放棄組隊後，所有邀請函皆會失效。\n\n確定要放棄組隊？" })
      end
    end
  end

  def transcript_instance_state(instance)
    case instance.state
    when 'teaming' then '組隊中'
    when 'in_progress' then '進行中'
    when 'complete' then '已完成'
    when 'abort' then '已放棄'
    end
  end
end
