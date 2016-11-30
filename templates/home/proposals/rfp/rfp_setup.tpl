{*{if $skip_js != 'true'}*}
{*{/if}*}
<!--//Edited by Waheed Ashraf  -->
{include file='home/proposals/rfp/css/rfp_css.tpl'}
<link rel="stylesheet" type="text/css" href="/{$BUILD_DIR}/resources/css/Aristo.css">
{assign var="renewal_option" value=','|explode:"renewal_option_1,renewal_option_2,renewal_option_3,renewal_option_4"}
{assign var="renewal_option_lease_term" value=','|explode:"renewal_option_1_lease_term,renewal_option_2_lease_term,renewal_option_3_lease_term,renewal_option_4_lease_term"}
{assign var="renewal_option_renewal_rate" value=','|explode:"renewal_option_1_renewal_rate,renewal_option_2_renewal_rate,renewal_option_3_renewal_rate,renewal_option_4_renewal_rate"}
<input type="hidden" id="deal_id" value="{$request.id}">

{assign var="renewal_option_rental_rates_field" value=','|explode:"renewal_option_1_rental_rates,renewal_option_2_rental_rates,renewal_option_3_rental_rates,renewal_option_4_rental_rates"}

<input type="hidden"   id="template_temp_storage_id"   value='{$request.template_id}_{$request.building_id}'>
{insert name=get_client_info deal_id=$request.id assign=clients_email}
<div id="emailDropdown" style="margin-left:72%;display: none;z-index: 10;font-size: 11px;font-weight: normal;">
    <form id="emailDropdown_form">
        <ul>
            <li><strong>To:</strong><br /><input type="text" name="addresses[]" id="email_to" value="{$clients_email}" class="ui-autocomplete-loading added_email ui-autocomplete-input"></li>
            <li style="padding-bottom:10px;">
                <label class="radio inline" style="padding-left: 20px;margin-top: 0;">
                    <input type="radio" name="file_type" value='doc' style="margin-left:-20px;position:static;" checked><span style="font-size:11px;">Word Doc</span>
                </label>
                <label class="radio inline" style="padding-left: 20px;margin-top: 0;">
                    <input type="radio" name="file_type" value='pdf' style="margin-left:-20px;position:static;"> <span style="font-size:11px;">PDF</span>
                </label>
            </li>
            <li><strong>Add a message:</strong><br /><textarea id="emailDropdown_msg" name="msg" rows="4" class="auto_size_off"></textarea></li>
            <li><input type="checkbox" id="emailDropdow_sendself" name="email_option" value="primary" checked> Send a copy to myself</li>
            <li style="padding:10px 0;">
                <a href="#" id="emailDropdown_add"><i class="icon-plus"></i><u> Add Recipient</u></a>
            </li>
        </ul>
    </form>
    <a style="float:left;" href="#" id="closeEmail">Close</a>
    <a href="#" class="btn btn-danger btn-small" id="sendEmailRFPReport" style="float:right;">Send</a>
    <div id="successEmail" class="email-alert-success"><i class="icon-ok icon-white"></i>&nbsp;&nbsp;&nbsp;Email Sent Successfully</div>
    <div id="failEmail" class="email-alert-fail"><i class="icon-remove-sign icon-white"></i>&nbsp;Please enter an email</div>
    <div id="processingEmail" class="email-alert-processing">Sending&nbsp;<img src="images/ajax-loader.gif" style="width:15px;"></div>
</div>

{*<div>*}
    <div id="rfp_language_tool" class="rfp_language rfp_language_main">
        <div class="rfp_language_data">
            <div class="rfp_language_right_column">
                <div class="rfp_language_text_preview"><i style="font-size: 8px;color: gray;">Select a field from the left to see preview</i></div>
                <div class="rfp_language_control_panel">
                    <a class="btn btn-mini" onclick="insert_stuff();">Insert</a>
                </div>
            </div>
            <table class="imageTable">
                <thead class="fixedHeader">
                <tr class="alternateRow">
                    <th scope="col" style="padding: 0;border-top-left-radius: 3px;border-top-right-radius: 3px;"><input type="text" class="text_input" id="filter" value="" placeholder="Search" style="width: 200px;float: left;font-size:11px;line-height: 14px;margin-left: 3px;margin-bottom: 6px;"/></th>
                </tr>
                </thead>
                <tbody id='available_table_body' class="scrollContent" style="max-height: 260px;text-align: left;"></tbody>
            </table>
            <a href="" class="customize_language_tool" style="float:left;padding-top: 5px;color:#0a68b4">Customize Language</a>
        </div>
    </div>
{*</div>*}

<div class="button_row row text-center">
    {if $document_type eq 'Document'}{assign var="onclick_save_return" value="document.location.href='/`$request.BUILD_DIR`/home?id=`$request.id`#building_tab_`$request.building_id`'"}{else}{assign var="onclick_save_return" value="if(check_fields())document.location.href='/`$request.BUILD_DIR`/home?id=`$request.id`#building_tab_`$request.building_id`'"}{/if}
    <button class="btn btn-default hide_link pull-left save_and_return {if $document_type eq 'Document'}ignore_check{/if}" building_id='{$request.building_id}' deal_id='{$request.id}' data-toggle="modal">
      <i class="fa fa-save"></i> Save & Return
    </button>
    {if $document_type neq 'Document' || ($request.word_doc eq 'true' && $check_if_rfp_word_doc)}<button id="testing_edit_field_button_{$request.building_id}"  class="btn btn-default rfp_modify_template_link"  role="button"><i class="fa fa-edit"></i> <span class="edit_title">Edit Fields</span></button>{/if}
      <div class="btn-group">
          <button type="button" class="btn btn-default dropdown-toggle text-size-small hide_link" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-sign-in"></i> Change Base RFP Form <span class="caret"></span></button>
          <ul class="dropdown-menu">
              {if $request.word_doc eq 'true'}
                  {assign var='only_rfp_weblink' value='false'}
                  {assign var='show_only_rfp_docs' value='true'}
              {else}
                  {assign var='only_rfp_weblink' value='true'}
                  {assign var='show_only_rfp_docs' value='false'}
              {/if}
              {if $request.offer eq 'true'}
                  {assign var='set_proposal_type' value='LOI'}
              {else}
                  {assign var='set_proposal_type' value='RFP'}
              {/if}
              {insert name=get_all_word_doc_proposals_for_building proposal_type=$set_proposal_type show_only_rfp_docs=$show_only_rfp_docs show_only_rfp_weblink=$only_rfp_weblink only_current_building='true' current_proposal_id = $request.proposal_id building_id=$request.building_id assign=get_word_doc_proposals_for_current_building}
              {insert name=get_building_title_from_id building_id=$request.building_id assign=get_building_title}
              {insert name=count_proposals_based_on_proposal_type only_docs=$show_only_rfp_docs proposal_type=$set_proposal_type current_proposal_id = $request.proposal_id building_id=$request.building_id assign=count_proposals_based_on_proposal_type}


                  <li class="dropdown-submenu {if !$get_word_doc_proposals_for_current_building[0] || !$count_proposals_based_on_proposal_type}disabled{/if}" ><a href='' data-toggle="dropdown">Use Current Building</a>
                      <ul class="dropdown-menu">
                          <li class="dropdown-submenu"><a class="copy_building_template_link" building_id="{$request.building_id}" rfp_type="TC" deal_id="{$request.id}" old_template_id="{$get_template_id}" copied_building_id="{$get_building_id}" >{$get_building_title}</a>
                              <ul class="dropdown-menu">
                                  {foreach from=$get_word_doc_proposals_for_current_building item=word_doc_proposal}
                                      <li><a class="create_rfp_word_doc" copy_request="create_rfp_from_previous_building" word_doc="{$request.word_doc}" proposal_id="{$request.proposal_id}" is_offer="{$request.offer}" building_id="{$request.building_id}" deal_id="{$request.id}" copied_proposal_id="{$word_doc_proposal.id}" >{$word_doc_proposal.proposal_name}</a></li>
                                  {/foreach}
                              </ul>
                          </li>
                      </ul>
                  </li>
              {insert name=get_all_proposals_for_deal only_doc=$show_only_rfp_docs rfp_type=$set_proposal_type proposal_id=$request.proposal_id building_id=$request.building_id }

              {*<li><a class="create_new_template" rfp_type="RFP" href="home.php?id={$request.id}&deal_id={$request.id}&ACTION=create&building_offer=false&current_building_id={$request.building_id}">Create New</a></li>*}

              {*{if $request.word_doc neq 'true'}*}
                  {*<li><a data-toggle="modal" copy_request="copy_from_standard_template" class="_open_standard_template_modal" rfp_offer="{$request.offer}" is_offer="{$request.offer}" request_type="RFP" word_doc="{if $request.word_doc eq 'true'}true{else}false{/if}" proposal_id="{$request.proposal_id}" building_id="{$request.building_id}"  template_type="generic">Use Standard Form</a></li>*}
              {*{/if}*}
              {insert name=create_standard_form_html rfp_offer=$request.offer is_offer=$request.offer request_type=$set_proposal_type proposal_id=$request.proposal_id word_doc=$request.word_doc building_id=$request.building_id }

              <li><a class="open_deal_info_modal" proposal_id="{$request.proposal_id}"  rfp_offer="false" building_id="{$request.building_id}" request_type="RFP" word_doc="{if $request.word_doc eq 'true'}true{else}false{/if}" template_type="project">Use Prior Deal Form</a></li>
              <li class="divider"></li>
              <li ><a class="create_rfp_word_doc" copy_request="create_new_rfp" rfp_type="{$set_proposal_type}" is_offer="{$request.offer}" deal_id="{$request.id}" word_doc="{if $request.word_doc eq 'true'}true{else}false{/if}" proposal_id="{$request.proposal_id}" building_id="{$request.building_id}">Start Over</a>
              </li>
          </ul>
      </div>
    <button class="btn btn-default show_comparison hide_link" building_id = {$request.building_id} proposal_id='{$rfp_proposal_id}'  role="button"><i class="fa fa-eye"></i> Preview</button>
    <button class="btn btn-default hide_link"  role="button" data-toggle="modal" onclick="move_stuff()"><i class="fa fa-list-alt"></i> Language Tool</button>
    <button class="btn btn-default hide_link pull-right save_and_return ignore_check" building_id='{$request.building_id}' deal_id='{$request.id}' data-toggle="modal"  role="button"><i class="fa fa-reply"></i> Back</button>
</div>
{insert name=get_proposal_name_from_proposal_id proposal_id=$request.proposal_id assign=get_proposal_name}
<div class="tc_head row">
    <div class="tc_head_title">
        <h3 class="company">
            {if $request.offer eq 'true' AND $request.revise eq 'true'}
                {if $get_proposal_name}{$get_proposal_name} {else}Revised LOI{/if} for {$current_building_title}
            {elseif $request.offer neq 'true' AND $request.revise eq 'true'}
                {if $get_proposal_name}{$get_proposal_name} {else}Revised RFP{/if} for {$current_building_title}
            {elseif $request.offer eq 'true'}
                {if $get_proposal_name}{$get_proposal_name} {else}LOI{/if} for {$current_building_title}
            {else}
                {if $get_proposal_name}{$get_proposal_name} {else}RFP{/if} for {$current_building_title}
            {/if}
        </h3>
        {*<div class="broker"><b>From {$contact.first_name} {$contact.last_name}, {$contact.firm}</b></div>*}
        {*<div class="rfpdate clearfix"><strong>Request Date</strong>: {$date_sent|date_format}</div>*}
    </div>
</div>
<div style="margin-bottom:40px;"></div>
<div id="Main" class="rfp_div_{$request.building_id} view_current_tc" style="width: 100%;display:flex;">
  
	{include file='home/proposals/rfp/rfp_sidebar.tpl'}
    <div class="empty_placeholder_div" style="display: none;min-width: 360px;">

    </div>
    <div class="content-wrapper included_fields_list_tbl_container static_mode" id="testing_included_{$request.building_id}">
        <input type='hidden' class='store_proposal_id' name='rfp_proposal_id' value='{$request.proposal_id}'>
        {if $document_type eq 'Document' && (!$check_if_rfp_word_doc || $request.word_doc neq 'true')}
            <input type="hidden" class='rfp_building_id' name="building_id"   value='{$request.building_id}'>
            {$rendered_doc}
        {else}
          <form id='rfp_setup_form' style="width: 100%;" action="#tabs-{$smarty.section.p.rownum}" method="post" enctype="multipart/form-data">
            {if $rfp_template_id eq ''}
                {assign var="rfp_template_id" value=$request.template_id}
            {/if}
              <input id="default_field_category_match_list" type="hidden" value="{$default_field_category_match_list|escape:'html'}">
            <input type='hidden' class='rfp_template_id' name='rfp_template_id' value='{$rfp_template_id}'>
            <input type="hidden" class='rfp_building_id' name="building_id"   value='{$request.building_id}'>
            <input type="hidden"   id="b_id"   value='{$request.building_id}'>
            <input type='hidden' name='return_url' id='return_url' value='' />
            <input type='hidden' name='type' value='add_rfp_doc' />
            <div class="rfp_controlbar" style="padding: 0px;">
                {*<div class="rfp_text">Select items below to include in your proposal.</div>*}
                <!--div class="clearfix"></div-->
                <div class="top_alert" style="display:none;"><span style="color:#d64100;"><i class="icon-exclamation-sign" style="vertical-align: initial;"></i> Highlighted items</span> require your attention</div>
                <!--div class="clearfix"></div-->
            </div>
            {insert name=get_count table=rfp_variable_category   assign=total}
            {insert name=get_rfp_value_by_variable_name proposal_id = $request.proposal_id variable_name="net_or_gross" building_id=$request.building_id assign=cur_net_or_gross}
            <!--added by Sonia 20120621 -->
            {insert name=get_includeFields building_id=$request.building_id assign=includeArr}
            {if $includeArr eq "none"}
                {insert name=get_name_includeFieldsDealWise deal_id=$request.id assign=includeArr}
            {/if}
            {insert name=get_defaultUncheckFields assign=uncheckArr}
			<style>
			{literal}
			.tbl_new_font{ font-family: "Raleway",Helvetica Neue,Helvetica,Arial,sans-serif!important; }
			.see_details_color:{ color:#0badf5; }
			{/literal}
			</style>
            <table class="tblep tbl_new_font included_fields_list_tbl" style=" width: 100%; table-layout: initial;">
                <tbody class="connected_field_transfer included_fields_tbody">
                <tr hidden components_status="included_fields" style="border:none; font-size: 20px !important; font-weight: bold;" category_sort="{$store_hidden_category_title.sort}" field_category_name="#_create_a_invisible_custom_category" list_type="category" title="" field_category="{$store_hidden_category_title.title|escape:html}" field_header="Category Header" category_id="{$store_hidden_category_title.id}" class="category_header active border-double">
                    <td colspan="3" style="border:none; font-size: 20px; width: 35%" class="category_title">
                        <i class="glyphicon glyphicon-remove" style="display:none;"></i>
                        {$store_hidden_category_title.title}
                    </td>
                </tr>
                {assign var="category_temp" value=""}
                {assign var="store_current_gross_value" value=$cur_net_or_gross}
                <input type="hidden" class="store_current_gross_value" value="{$cur_net_or_gross}" />

                {foreach from=$included_rfp_fields key=i item=field}
                  {insert name=read_proposal_value_data id=$field.id rfp_template_id=$request.template_id proposal_id=$request.proposal_id assign=rfp_variable_b}
                  {insert name=get_rfp_default_value deal_id=$request.id building_id=$request.building_id proposal_id=$request.proposal_id rfp_variable_id=$rfp_variable_b.variable_id assign=default_value_b}
                  {insert name=get_display_operating_expense_tbl_row_for_rfp_setup net_gross_status=$rfp_variable_b.net_gross_stasus rfp_net_gross=$cur_net_or_gross building_id=$request.building_id rfp_template_id=$request.template_id var_id=$rfp_variable_b.id assign=display_operating_expense_tbl_row}
                {if $request.word_doc eq 'true'}
                {assign var="display_operating_expense_tbl_row" value="1"}
                {/if}
                {if $display_operating_expense_tbl_row eq 1}
                   {insert name=get_previous_value_by_name_for_strike_out report_mode='true' building_id=$request.building_id proposal_id=$request.proposal_id variable_name=$rfp_variable_b.name option_key=0 assign=previous_value}

              {assign var="rfp_variable_name" value=$rfp_variable_b.name}
              {assign var="cur_proposal_id" value=$request.proposal_id}
              {assign var="cur_building_id" value=$request.building_id}
                            {assign var="cur_option_key" value='0'}
                  {if $category_temp neq $field.category_title}
                    {assign var="category_temp" value=$field.category_title}{* category title *}
                    {*if $display_operating_expense_tbl_row*}

                      <tr components_status="included_fields" style="border:none;{if $field.category_name eq '#_create_a_invisible_custom_category' } display:none;{/if} font-size: 20px !important; font-weight: bold;" category_sort="{$field.category_sort}" list_type="category" title="" field_category="{$field.category_title|escape:'html'}" field_category_name="{$field.category_name}" field_header="Category Header" category_id="{$field.category_id}" class="category_header active border-double">
                        <td colspan="3" style="background:#2b4f73; color:#FFFFFF; border:none; font-size: 20px; width: 35%" class="category_title">
                          <i class="glyphicon glyphicon-remove" style="display:none;"></i>
                          {$field.category_title}
                        </td>
                      </tr>
                    {*/if*}
                  {/if}
                      {insert name=check_if_proposal_created_is_rfp proposal_id=$request.proposal_id assign=proposal_is_rfp}
                      {insert name=get_variable_child_b proposal_id=$request.proposal_id rfp_variable_parent_id=$rfp_variable_b.variable_id  building_id=$request.building_id assign=rfp_variable_child_title_b}
                {insert name=show_abatement_type_abatement_rates proposal_id=$request.proposal_id building_id=$request.building_id assign=display_abatement_type}
                  {if $rfp_variable_b.visible eq "Yes"}
                      <tr   components_status="included_fields" is_custom_field="{if $rfp_variable_b.is_custom_field}true{else}false{/if}" {if ($rfp_variable_b.name eq 'abatement_type' && !$display_abatement_type) || !$display_operating_expense_tbl_row || ($rfp_variable_b.name eq 'rental_rate_type' && $proposal_is_rfp)  }style="display:none;"{/if} list_type="field" class="{$rfp_variable_b.net_gross_stasus} rfp_item highlight {if $rfp_variable_b.proposalFieldReq eq '1'}required_field{/if}" variable_id="{$rfp_variable_b.variable_id}" field_type="{$rfp_variable_b.field_type}"  data-title="{$rfp_variable_b.title|escape:'html'}" data-name="{$rfp_variable_b.name|escape:'html'}" field_category="{$rfp_variable_b.category_title|escape:'html'}" id="rfp_input_{$request.building_id}_{$rfp_variable_b.variable_id}" name="{$rfp_variable_b.name}">
                        {if  $rfp_variable_b.name == "expense_stop_type"}
                          <input type="hidden" name="expStop_id" id="expStop_id" value="rfp_input_{$request.building_id}_{$rfp_variable_b.variable_id}" />
                        {/if}
                       <td class="rfp_title parent_field col-xs-12 col-sm-6 col-lg-4"  {if $rfp_variable_b.name neq 'unreserved_parking' AND $rfp_variable_b.name neq 'reserved_parking'} onclick="check_table_answer_child('field_{$request.building_id}_{$rfp_variable_b.id}','field');" {/if}>
                    {if $rfp_variable_b.proposalFieldReq neq '1'}
                      <i class="glyphicon glyphicon-remove" style="display:none;"></i>
                    {else}
                      <div class="space_fill_remove"></div>
                    {/if}
                          {if ($rfp_variable_b.name eq "reserved_spaces" or $rfp_variable_b.name eq "unreserved_spaces") AND $rfp_variable_b.is_custom_field == '0'}
                          <b id="{$rfp_variable_b.name}_title" target="{$parking_type_value}">{if $parking_type_value eq 'ratio'}{$rfp_variable_b.title}{elseif $rfp_variable_b.name eq "unreserved_spaces"}# Unreserved Spaces{else}# Reserved Spaces{/if}</b>
                    {elseif $rfp_variable_b.name eq "rental_rate_type"}
                    <b>{if $request.offer eq 'true'}Rental Rates{else}{$rfp_variable_b.title}{/if}</b>
                          {elseif  @in_array($rfp_variable_b.name,$renewal_option)}
                              <b id="{$rfp_variable_b.name}_title">{$rfp_variable_b.title}</b>
                          {else}
                          {insert name=get_tooltip  field_name=$rfp_variable_b.name assign=rfp_tooltip}
                          <b {$rfp_tooltip}>{$rfp_variable_b.title}</b>
                          {/if}
                          {if $rfp_variable_b.name neq 'unreserved_parking' and $rfp_variable_b.name neq 'reserved_parking' and !in_array($rfp_variable_b.name,$renewal_option)}
                      {if $rfp_variable_child_title_b[0].variable_id}
                        {*<div style="float:right"><img src="images/plus.png" id='plus_field_{$request.building_id}_{$rfp_variable_b.id}' height="11" width="11" alt="" /></div>*}
                        <div style="float:right">
                          <a id="plus_field_{$request.building_id}_{$rfp_variable_b.id}" class="see_details text-primary text-light see_details_color"><b> See Details </b></a>{* {$rfp_variable[i].id} *}
                        </div>
                      {/if}
					 
                          {/if}
                          {if $rfp_variable_b.field_type == "Combobox"}
                          <div id="monthly_rate_title_{$request.building_id}" style="display:none;width:100%;">
                            <div style='vertical-align:middle;'>
                              <p style='margin-top:30px;'>Monthly Rental Rates: <font color='#ff0000'> </font></p>
                            </div>
                          </div>
                          <div id="yearly_rate_title_{$request.building_id}" style="display:none;width:100%;">
                            <div style='vertical-align:middle;'>
                              <p style='margin-top:30px;'>Yearly Rental Rates: <font color='#ff0000'> </font></p>
                            </div>
                          </div>
                          {/if}
                    {if $rfp_variable_b.is_custom_field && $rfp_variable_b.name != 'secondary_leasing_agent_name'}
                      <div class="remove_custom_field_div">
                        <a title="Remove" class="remove_custom_field" field_type="{if $rfp_variable_b.custom_type eq 'Project'}project_field{elseif $rfp_variable_b.custom_type eq 'Building'}building_field{/if}"  rfp_id="{$rfp_variable_b.variable_id}">
                         - Remove optional field
                        </a>
                      </div>
                    {/if}
                    <input type='hidden' name='variable_tenant_comment[{$rfp_variable_b.id}]' value='{$rfp_variable_b.comment}' id='hidden_info_{$rfp_variable_b.id}' />
                        <div id="info_{$rfp_variable_b.id}" proposal_id="{$rfp_variable_b.proposal_id}" template_id="{$rfp_template_id}" building_id="{$rfp_variable_b.building_id}" style="display:none;" title="{$rfp_variable_b.title}" field_type="{$rfp_variable_b.field_type}" height='350' save_id="{$rfp_variable_b.id}" option_key="0">
                        {if $rfp_variable_b.field_type neq 'Textarea'}{$rfp_variable_b.title}&nbsp;&nbsp;{/if}
                            <input type="hidden" class="pre_comment_{$rfp_variable_b.id}" value="{$rfp_variable_b.value|escape:html}">

                            {if $rfp_variable_b.field_type == "Textbox" || $rfp_variable_b.field_type == "Numeric" || $rfp_variable_b.field_type == "Dollar" ||$rfp_variable_b.field_type == "Percentage" ||$rfp_variable_b.field_type == "Email" ||$rfp_variable_b.field_type == "Web Link"}
                              {include file='home/proposals/rfp/RFP_Field/RFP_Textbox_if.tpl'}
                            {elseif $rfp_variable_b.field_type == "Date"}
                              {include file='home/proposals/rfp/RFP_Field/RFP_Date_if.tpl'}
                            {elseif $rfp_variable_b.field_type eq "Attached Files"}
                              {include file='home/proposals/rfp/RFP_Field/RFP_AttachedFiles_if.tpl'}
                            {elseif $rfp_variable_b.field_type == "Textarea"}
                              {include file='home/proposals/rfp/RFP_Field/RFP_Textarea_if.tpl'}
                            {elseif $rfp_variable_b.field_type == "Selectbox"}
                              {include file='home/proposals/rfp/RFP_Field/RFP_Selectbox_if.tpl'}
                            {elseif $rfp_variable_b.field_type == "Combobox"}
                              {include file='home/proposals/rfp/RFP_Field/RFP_Combobox_if.tpl'}
                            {elseif $rfp_variable_b.field_type == "Radio"}
                                <input type="radio" name ="variable[{$rfp_variable_b.id}]" value="No" checked>No
                                <input type="radio" name ="variable[{$rfp_variable_b.id}]" value="Yes" {if $rfp_variable_b.value eq "Yes"}checked{/if}>Yes &nbsp;<font color='#ff3300'></font>
                            {/if}
                      {if $rfp_variable_b.read_only neq 'Yes' and $rfp_variable_b.field_type neq 'Textarea'}

                            <!--<h3>{$rfp_variable_b.title}</h3>-->
                      Write your comment below:<br><textarea id ="text_info_{$rfp_variable_b.id}" proposal_value_id="{$rfp_variable_b.id}" save_id="{$rfp_variable_b.id}" class="form-control" rows="10" cols="8">{$rfp_variable_b.comment|strip_tags}</textarea>
 {/if}
                        </div>
                        </td> <!-- /rfp_title -->

                        <td class="rfp_value attribute_col col-xs-12 col-sm-6 col-lg-8" >
					<span control_field_attribute="{$rfp_variable_b.field_type}" title="Field type" class="label bg-warning-400" controll-attribute="field_type">{$rfp_variable_b.field_type}</span>
                    <span title="Field category" class="label bg-blue" controll-attribute="field_category" control_field_attribute="{$rfp_variable_b.category_title}">{$rfp_variable_b.category_title}</span>
                          <div class="static_text_values">
                         <div class="preview_value_{$rfp_variable_b.id}">
                              {if $rfp_variable_name == "rental_rate_type"  && !$check_if_rfp_word_doc} {* display value *}
                            {insert name=display_special_field_strikeout_value_rfp_report proposal_id=$cur_proposal_id proposal_value_id=$rfp_variable_b.id previous_value=$previous_value current_value=$rfp_variable_b unit="" proposal_id=$cur_proposal_id building_id=$cur_building_id option_key=$cur_option_key}
                        {elseif $rfp_variable_name eq 'net_or_gross' && !$check_if_rfp_word_doc}
                              {insert name=display_special_field_strikeout_value_report proposal_id=$cur_proposal_id proposal_value_id=$rfp_variable_b.id previous_value=$previous_value current_value=$rfp_variable_b unit="" proposal_id=$cur_proposal_id building_id=$cur_building_id option_key=$cur_option_key}
                        {elseif $rfp_variable_name eq "expense_stop_type"  && !$check_if_rfp_word_doc}
                            {insert name=display_special_field_strikeout_value_report proposal_id=$cur_proposal_id proposal_value_id=$rfp_variable_b.id previous_value=$previous_value current_value=$rfp_variable_b unit="" proposal_id=$cur_proposal_id building_id=$cur_building_id option_key=$cur_option_key}
                        {elseif $rfp_variable_name eq 'rental_abatement' AND $rfp_variable_b.is_custom_field eq '0'  && !$check_if_rfp_word_doc}
							{insert name=display_special_field_strikeout_value_report proposal_id=$cur_proposal_id proposal_value_id=$rfp_variable_b.id previous_value=$previous_value current_value=$rfp_variable_b unit=$rfp_variable_b.units proposal_id=$cur_proposal_id building_id=$cur_building_id option_key=$cur_option_key}
                        {elseif $rfp_variable_name eq 'construction_type' AND $rfp_variable_b.is_custom_field eq '0'  && !$check_if_rfp_word_doc}

                            {insert name=display_special_field_strikeout_value_report proposal_id=$cur_proposal_id proposal_value_id=$rfp_variable_b.id previous_value=$previous_value current_value=$rfp_variable_b unit="" proposal_id=$cur_proposal_id building_id=$cur_building_id option_key=$cur_option_key}
                        {elseif ($rfp_variable_name eq 'unreserved_spaces' or $rfp_variable_name eq 'reserved_spaces') AND $rfp_variable_b.is_custom_field eq '0'  && !$check_if_rfp_word_doc}
                            {insert name=display_special_field_strikeout_value_report proposal_id=$cur_proposal_id field_name=$rfp_variable_name previous_value=$previous_value current_value=$rfp_variable_b proposal_id=$cur_proposal_id building_id=$cur_building_id option_key=$cur_option_key}
                        {else}
                          {if $rfp_variable_b.field_type eq 'Attached Files'}
                          {insert name=display_special_field_strikeout_value_report proposal_value_id = $rfp_variable_b.id field_name="file_attachment" proposal_id=$cur_proposal_id previous_value=$previous_value current_value=$rfp_variable_b unit="" proposal_id=$cur_proposal_id building_id=$cur_building_id option_key=$cur_option_key}
                          {elseif $rfp_variable_b.field_type eq 'Textarea'}

                            <div id="static_redline_{$cur_proposal_id}_{$rfp_variable_b.id}_0" class="comment-in-table">
                          {if $rfp_variable_b.redline_comment neq ""}{$rfp_variable_b.redline_comment|stripslashes}{else}{$rfp_variable_b.value}{/if}
                        </div>
                  {else}
                          {insert name=display_redline_strikeout_value previous_value=$previous_value proposal_id=$cur_proposal_id current_value=$rfp_variable_b unit=$rfp_variable_b.units field_type=$rfp_variable_b.field_type stage=$cur_stage}

                  {/if}
                {/if}
				
				</div>
                {if $rfp_variable_b.is_editable!="No" || $rfp_variable_b.name eq 'building_hours' || $rfp_variable_b.name eq 'building_information_attachments' }
				 <div class="preview_comment_{$rfp_variable_b.id}">
				    {$rfp_variable_b.comment}
                 </div>

				<a href="#" role="button" proposal_value_id="{$rfp_variable_b.id}" field_name="{$rfp_variable_b.name}" proposal_id="{$rfp_variable_b.proposal_id}" template_id="{$rfp_template_id}" building_id="{$rfp_variable_b.building_id}" class="text-primary text-light view_comment view_comment_link_{$rfp_variable_b.id}" comment_title="RFP: {$rfp_variable_b.title} Information" field_name="{$rfp_variable_b.name}" style="font-size: 11px;"  form_id="info_{$rfp_variable_b.id}" hidden_text="yes" data-toggle="modal" onclick="">
				<button style="background:#2b4f73; color:#FFFFFF; border:0; float:right;padding: 3px 10px;" role="button">Modify <i class="fa fa-edit" style="color:#f99209"></i></button>
				</a>
{/if}
                          </div>
                          {if $cur_options gt 1 and $rfp_variable_b.multiple_options eq "1"}
                          &nbsp;
                          <span style="text-decoration: underline;font-size: 11px;line-height: 14px;font-weight: 600">
                            {assign var=option_key_foo value=$rfp_variable_b.sort}
                            {if $proposal_names[$option_key_foo]}{$proposal_names[$option_key_foo]}{else}Option {$rfp_variable_b.option_count}{/if}
                          </span><span style="margin-left: 3px;"><a href="#confirm_remove_options" class="remove_option" role="button" data-toggle="modal" option_key="0" onclick="$('#target_option_text').attr('option_key','0');$('#target_option_text').text('{$rfp_variable_b.option_count}')">X</a></span>
                          {/if}
                        </td> <!-- /rfp_value -->
                      </tr> <!-- /rfp_item -->
                        {section name=k loop=$rfp_variable_child_title_b}
                        {if !in_array($rfp_variable_child_title_b[k].name,$renewal_option_rental_rates_field)}
                       <tr class="rfp_item rfp_child_field child_field_tr_{$rfp_variable_b.variable_id}" list_type="field" data-title="{$rfp_variable_child_title_b[k].title}" data-name="{$rfp_variable_child_title_b[k].name}" field_category="{$field.category_title}" field_type="{$rfp_variable_child_title_b[k].field_type}" variable_id="{$rfp_variable_child_title_b[k].variable_id}"  cls="cls_field_{$request.building_id}_{$rfp_variable_child_title_b[k].id}" {if $rfp_variable_b.name neq 'unreserved_parking' AND $rfp_variable_b.name neq 'reserved_parking'}  id="field_{$request.building_id}_{$rfp_variable_child_title_b[k].id}" {/if} style=" width:100%; {if $rfp_variable_b.name eq 'unreserved_parking' or $rfp_variable_b.name eq 'reserved_parking' or in_array($rfp_variable_b.name,$renewal_option)}{else}display:none;{/if} id="rfp_input_child_{$rfp_variable_child_title_b[k].id}" name="{$rfp_variable_child_title_b[k].name}" parent_id="field_{$request.building_id}_{$rfp_variable_b.id}">
                          <!--<div style="width:38%;float:left;">{$rfp_variable_child_title_b[k].title}</div><div style="width:50%;float:left; vertical-align:top; background:#fafafa;"><div style="float:left; width:20px; height:20px;"><input type="image" src="images/arrow_corner.png" name="image" class="popup" title="{$rfp_variable_b[i].title}" form_id="info_cmt"></div>-->

                  {insert name=get_tooltip  field_name=$rfp_variable_child_title_b[k].name assign=rfp_child_tooltip}
                          <td class="rfp_title" {$rfp_child_tooltip}>
                    <input type='hidden' name='variable_tenant_comment[{$rfp_variable_child_title_b[k].id}]' value='{$rfp_variable_child_title_b[k].comment}' id='hidden_info_{$rfp_variable_child_title_b[k].id}' />
                    &nbsp;&nbsp;&nbsp;{$rfp_variable_child_title_b[k].title}
                     <div id="info_{$rfp_variable_child_title_b[k].id}" title="{$rfp_variable_child_title_b[k].title}" save_id="{$rfp_variable_child_title_b[k].id}" style="display:none;" height='350' >
                                                           {$rfp_variable_child_title_b[k].title}&nbsp;&nbsp;

                                                           {include file='home/proposals/rfp/RFP_Field/RFP_Child_Fields_if.tpl'}
                          {assign var='store_comment_value' value=$rfp_variable_child_title_b[k].comment}

{if $rfp_variable_child_title_b[k].read_only neq 'Yes' and $rfp_variable_child_title_b[k].field_type neq 'Attached Files' }
                                                Write your comment below:<br><textarea id ="text_info_{$rfp_variable_child_title_b[k].id}" class="form-control" style="height:185px;padding:0px;margin:5px 5px 5px 0;">{$rfp_variable_child_title_b[k].comment|strip_tags}</textarea>

                     {/if}
                          </div>
                  </td>
                          <td class="rfp_value">
                            <div style="float:left; width: 100%;">
                              <!--&nbsp;-->
                         {insert name=get_previous_value_by_name_for_strike_out report_mode='true' building_id=$request.building_id proposal_id=$request.proposal_id variable_name=$rfp_variable_child_title_b[k].name option_key=0 assign=child_previous_value}

                        <div class="preview_value_{$rfp_variable_child_title_b[k].id}">
                        {if $rfp_variable_child_title_b[k].field_type eq 'Attached Files'}
                          {insert name=display_special_field_strikeout_value_report field_name="file_attachment" proposal_id=$cur_proposal_id previous_value=$child_previous_value current_value=$rfp_variable_child_title_b[k] unit="" proposal_id=$cur_proposal_id building_id=$cur_building_id option_key=$cur_option_key}
                  {else}
                  {if in_array($rfp_variable_child_title_b[k].name,$renewal_option_renewal_rate)}
                                          {insert name=get_previous_value_by_name_for_strike_out report_mode='true' building_id=$request.building_id proposal_id=$request.proposal_id variable_name=$rfp_variable_child_title_b[k].name option_key=0 assign=child_previous_value}

                            {insert name=display_special_field_strikeout_value_rfp_report proposal_value_id=$rfp_variable_child_title_b[k].id proposal_id=$cur_proposal_id field_name=$rfp_variable_child_title_b[k].name previous_value=$child_previous_value current_value=$rfp_variable_child_title_b[k] proposal_id=$cur_proposal_id building_id=$cur_building_id option_key=$cur_option_key}
                   {else}
                          {insert name=display_redline_strikeout_value previous_value=$child_previous_value proposal_id=$cur_proposal_id current_value=$rfp_variable_child_title_b[k] unit=$rfp_variable_child_title_b[k].units field_type=$rfp_variable_child_title_b[k].field_type stage=$cur_stage}
                    {/if}
                  {/if} </div>

                       {if $rfp_variable_child_title_b[k].is_editable!="No" AND $rfp_variable_child_title_b[k].field_type neq 'Attached Files' AND $rfp_variable_child_title_b[k].field_type neq 'Date'}
                         <div class="preview_comment_{$rfp_variable_child_title_b[k].id}">
                                          {$rfp_variable_child_title_b[k].comment}
                         </div>

<a href="#" role="button" style="font-size: 11px;" field_name="{$rfp_variable_child_title_b[k].name}" proposal_id="{$rfp_variable_child_title_b[k].proposal_id}" template_id="{$rfp_template_id}" building_id="{$rfp_variable_child_title_b[k].building_id}" class=" text-primary text-light view_comment view_comment_link_{$rfp_variable_child_title_b[k].id}" proposal_value_id="{$rfp_variable_child_title_b[k].id}" comment_title="Proposal: {$rfp_variable_child_title_b[k].title} Information" field_name="{$rfp_variable_child_title_b[k].name}" form_id="info_{$rfp_variable_child_title_b[k].id}" hidden_text="yes" data-toggle="modal" onclick="">
                            <button style="background:#2b4f73; color:#FFFFFF; border:0; float:right;padding: 3px 10px;" role="button">Modify <i class="fa fa-edit" style="color:#f99209"></i></button>
                          </a>{/if}
                            </div>
                          </td> <!-- /rfp_value -->

                        </tr> <!-- /rfp_item -->{/if}
                        {/section}
                      {else}
                      <!--VariableNotVisible-->
                      <input type="hidden" name ="variable[{$rfp_variable_b.id}]" value='{$rfp_variable_b.value}'  />
                      {/if}
                    {*/section*} {* loop $rfp_variable_b *}
                    <!--</div> /.rfp_content -->
                  {*/section*}
              {/if}{* / $display_operating_expense_tbl_row eq 1*}
                {/foreach} {* / foreach from=$included_rfp_fields key=i item=field *}
                {foreach from=$left_rfp_category key=j item=category}
                    <tr components_status="included_fields" style="border:none; font-size: 20px !important; font-weight: bold; display:none" category_sort="{$category.sort}" list_type="category" title="" field_category="{$category.title|escape:html}" field_header="Category Header"  category_id="{$category.id}" class="category_header active border-double all_categories">
                        <td colspan="3" style="border:none; font-size: 20px; width: 35%" class="category_title">
                            <i class="glyphicon glyphicon-remove" style="display:none;"></i>
                            {$category.title}
                        </td>
                    </tr>
                {/foreach}

                {*foreach from=$included_rfp_fields key=i item=field*}
                </tbody> <!-- -->
            </table> <!-- class="tblep included_fields_list_tbl"  -->
        </form>
        {/if}
    </div>
    <br style="clear:both">
</div>
<div id="add_custom_field_id" save_id="" option_key=""style="display:none;" height='350' >
    <input type="hidden" class="project_field_stage" value="rfp_building_custom_field_rfp_value">
    <input type="hidden" class="building_field_stage" value="rfp_building_custom_field">
    <table class="custom_field_tbl">
        <tr>
            <td>Name</td>
            <td><input class="custom_field_name" type="text"></td>
        </tr>
        <tr>
            <td>Category</td>
            <td>
                <select class="custom_field_category">
                    {section name=c loop=$rfp_variable_category}
                        <option value="{$rfp_variable_b.category_id}">{$rfp_variable_b.title}</option>
                    {/section}
                </select>
            </td>
        </tr>
        <tr>
            <td>Field Type</td>
            <td>
                {insert name=get_rfp_field_type assign=field_type_array}
                <select class="custom_field_type">
                    {foreach from=$field_type_array key=k item=field_type}
                        <option value="{$k}">{$field_type}</option>
                    {/foreach}
                </select>
                <div class="custom_numeric_analysis_field">
                    <input class="custom_numeric_analysis" type="checkbox">
                    <span class="custom_numeric_analysis_label">Analysis</span>
                </div>
            </td>
        </tr>
    </table>
    <div id="custom_field_selectbox_option">
        <h5 class="custom_field_option_header">Custom Field Option</h5>
        <table class="custom_field_option_tbl">
            <tr class="custom_field_tbl_row">
                <td><span class="field_option">Option 1</span></td>
                <td>
                    <input type="text" class="custom_select_option">
                    <a class="add_custom_select_option">Add Option</a>
                </td>
            </tr>
        </table>
    </div>
</div>
<div class="button_fixed_toolbar text-center">
  <button type="button" class="btn btn-link hide_link ml-20 pull-left save_and_return {if $document_type eq 'Document'}ignore_check{/if}" building_id='{$request.building_id}' deal_id='{$request.id}' data-toggle="modal"><i class="fa fa-save"></i> Save & Return</button>
  {if $document_type neq 'Document'}<button id="testing_edit_field_button_{$request.building_id}"  class="btn btn-link rfp_modify_template_link"  role="button"><i class="fa fa-edit"></i> <span class="edit_title">Edit Fields</span></button>{/if}
  <div class="btn-group">
    <button type="button" class="btn btn-link dropdown-toggle text-size-small hide_link" data-toggle="dropdown" aria-expanded="false"><i class="fa fa-sign-in"></i> Change Base RFP Form <span class="caret"></span></button>
    <ul class="dropdown-menu">
      <li class="dropdown-submenu {if !$get_word_doc_proposals_for_current_building[0] || !$count_proposals_based_on_proposal_type}disabled{/if}" ><a href='' data-toggle="dropdown">Use Current Building</a>
        <ul class="dropdown-menu">
          <li class="dropdown-submenu"><a class="copy_building_template_link" building_id="{$request.building_id}" rfp_type="TC" deal_id="{$request.id}" old_template_id="{$get_template_id}" copied_building_id="{$get_building_id}" >{$get_building_title}</a>
            <ul class="dropdown-menu">
              {foreach from=$get_word_doc_proposals_for_current_building item=word_doc_proposal}
                <li><a class="create_rfp_word_doc" copy_request="create_rfp_from_previous_building" word_doc="{$request.word_doc}" proposal_id="{$request.proposal_id}" is_offer="{$request.offer}" building_id="{$request.building_id}" deal_id="{$request.id}" copied_proposal_id="{$word_doc_proposal.id}" >{$word_doc_proposal.proposal_name}</a></li>
              {/foreach}
            </ul>
          </li>
        </ul>
      </li>
      {insert name=get_all_proposals_for_deal only_doc=$show_only_rfp_docs rfp_type=$set_proposal_type proposal_id=$request.proposal_id building_id=$request.building_id }
      {if $request.word_doc neq 'true'}
        <li><a data-toggle="modal" copy_request="copy_from_standard_template" class="_open_standard_template_modal" is_offer="{$request.offer}" request_type="RFP" word_doc="{if $request.word_doc eq 'true'}true{else}false{/if}" proposal_id="{$request.proposal_id}" building_id="{$request.building_id}"  template_type="generic">Use Standard Form</a></li>
      {/if}
      <li><a class="open_deal_info_modal" proposal_id="{$request.proposal_id}"  rfp_offer="false" building_id="{$request.building_id}" request_type="RFP" word_doc="{if $request.word_doc eq 'true'}true{else}false{/if}" template_type="project">Use Prior Deal Form</a></li>
      <li class="divider"></li>
      <li ><a class="create_rfp_word_doc" copy_request="create_new_rfp" is_offer="{$request.offer}" deal_id="{$request.id}" word_doc="{if $request.word_doc eq 'true'}true{else}false{/if}" proposal_id="{$request.proposal_id}" building_id="{$request.building_id}">Start Over</a>
      </li>
    </ul>
  </div>
  <button class="btn btn-link show_comparison hide_link" building_id = {$request.building_id} proposal_id='{$rfp_proposal_id}'  role="button"><i class="fa fa-eye"></i> Preview</button>
  <button class="btn btn-link hide_link"  role="button" data-toggle="modal" onclick="move_stuff()"><i class="fa fa-list-alt"></i> Language Tool</button>
  <button class="btn btn-link hide_link mr-20 pull-right save_and_return ignore_check" building_id='{$request.building_id}' deal_id='{$request.id}' data-toggle="modal"  role="button"><i class="fa fa-reply"></i> Back</button>
</div>
{include file='home/proposals/rfp/js/rfp_js.tpl'}
