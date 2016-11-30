<!--div id="sidebar_blocker"></div-->
<!-- Secondary sidebar    --->
<div id="rfp_sidebar" class="sidebar sidebar-secondary sidebar-default" style="display:none;">
<style>
{literal}
.new_heading_div{  
	color: #2b4f73;
	float: left;
	margin-bottom: 50px;
	margin-top: -33px;
	position: absolute;
	width: 1150px;
}
.select_text_heading {
	float: left;
	text-align: center;
	font-weight: bold;
	width: 51%;
}
.remove_text_heading{
	float: left;
	margin-left: 15px;
	width: 230px;
	color:#94a9be;
}
.form_field_heading{
	float: left;
	margin-left: 15px;
	font-weight: bold;
	width: 180px;
}
 .tabbable .nav-sidebar .active{ background:#2b4f73; }
 .tabbable .nav-sidebar .active .a_tag_style .position-right{ color:#FFFFFF; }
 .tabbable .nav-sidebar .active .a_tag_style .caret{ color:#FFFFFF; }
 .dropdown .dropdown-menu{ min-width:208px; }
 #rfp_sidebar, .sidebar { min-width:590px;}
 #rfp_sidebar .sidebar-content { min-width:570px;}
 .empty_placeholder_div{ min-width:590px !important;}
  
  .tabbable .nav-sidebar {
  margin-bottom:20px /*---*/
}
  
  .tabbable .nav-sidebar > li.active{
    position: relative;
  }
    .tabbable .nav-sidebar > li.active:after{
    border-top: 10px solid #2b4f73;
    border-left: 10px solid transparent;
    border-right: 10px solid transparent;
    content: "";
    height: 0;
    left: 0;
    margin: auto;
    position: absolute;
    right: 0;
    width: 0;

  }
 .first_tab_fields { 
	border-right:5px solid #919499;
	float:left !important;
	width:180px !important;
 } 
 .second_tab_cat{
	border-right:5px solid #919499;
	float:left !important;
	width:180px !important;
	 
 }
 span.a_tag_style{ 
 	background:#aaafb3; color:#d1d4d9;
	}
/* .position-right{color:#d0d3d8;}*/
{/literal}
</style>

 <div class="sidebar-content">
   <div class="new_heading_div"> 
   <div class="select_text_heading"> Select Options</div>
   <div class="remove_text_heading"> REMOVE </div> 
   <div class="form_field_heading"> Form Fields </div> 
   
  </div>
    <!-- Sidebar tabs -->
	
    <div class="tabbable sortable">
      <ul class="nav nav-lg nav-tabs nav-justified nav-sidebar">
        <li class="active first_tab_fields">
          <span class="a_tag_style excluded_save_tab_status" href="#fields-tab" data-toggle="tab">
            <!--<i class="icon-grid-alt"></i>-->
            <span class="position-right text-size-small text-regular">Fields</span>
          </span>
        </li>

        <li class="second_tab_cat">
          <span class="a_tag_style excluded_save_tab_status" href="#categories-tab" data-toggle="tab">
            <!--<i class="icon-menu6"></i>-->
            <span class="position-right text-size-small text-regular">Categories</span>
          </span>
        </li>
        <li class="dropdown rfp_sidebar_dropdown">
          <span class="a_tag_style excluded_save_tab_status dropdown-toggle" href="#" data-toggle="dropdown" style="width:208px;">
            <!--<i class="icon-grid5"></i>-->
            <span class="position-right text-size-small text-regular">Custom</span>
            <span class="caret"></span>
          </span>
          <ul class="dropdown-menu dropdown-menu-right">
            <li><a href="#add-field-tab" data-toggle="tab" class="excluded_save_tab_status">Create Field</a></li>
            <li><a href="#add-category-tab" data-toggle="tab" class="excluded_save_tab_status">Create Category</a></li>
          </ul>
        </li>
      </ul>

      <div class="tab-content">
        <div class="excluded_fields_list_tbl_container">
          <div class="field_tool_bar">
            Search <input type="text" class="fields_title_text"><i class="icon-backspace clear_field_search"></i>
            <div class="field_list_tr_header">
              <div>
                <span class="sort_excluded_field_list">
                  Title <i class="icon-arrow-up22 sort_arrow" sort_targert="data-title" sort_asc=""></i>
                </span>
              </div>
              <div>
                <span class="sort_excluded_field_list">
                  Category <i class="icon-arrow-up22 sort_arrow" sort_targert="field_category" sort_asc=""></i>
                </span>
              </div>
            </div>
          </div>
          <table class="table datatable-show-all excluded_fields_list_tbl">
            <tbody class="tab-pane active no-padding connected_field_transfer" id="fields-tab">
              {foreach from=$excluded_rfp_fields key=i item=field}
                <tr components_status="excluded_fields" list_type="field" title="" value="option{$i}" field_type="{$field.field_type}" field_category="{$field.category_title}" data-title="{$field.title}"  data-name="{$field.name}">
                  <td class="rfp_title" style="width:49%"><i class="glyphicon glyphicon-remove"></i>{$field.title}</td>
                  <td class="attribute_col" style="width:35%">
                    <span control_field_attribute="{$field.field_type}" style="display:none;" title="Field type" class="label bg-warning-400" controll-attribute="field_type">{$field.field_type}</span>
                    <span style="float: left;height:22px;width:4px; display:block" controll-attribute="field_category" control_field_attribute="{$field.category_title}"> </span><span class="label" style="color:#000000; margin-left:10px;"> {$field.category_title}</span>
					<!--<span title="Field category" class="label bg-blue" controll-attribute="field_category" control_field_attribute="{$field.category_title}">{$field.category_title}</span>-->
					
                  </td>
                  <td class="rfp_comment" title="Include this field" style="width:16%"></td>
                </tr>
              {/foreach}                
            </tbody>
            <tbody class="tab-pane no-padding" id="categories-tab">
              <tr class='no_category_placeholder'>
                <td>
                  <i style='font-size:smaller;'>All the categories are included</i>
                </td>
              </tr>
              {foreach from=$complete_rfp_category_excluded key=j item=category}
                <tr components_status="excluded_fields" category_sort="{$category.sort}" list_type="category" title="" field_category="{$category.title|escape:'url'}" field_category_name="{$category.title|lower|replace:' ':'_'}" field_header="Category Header" category_id="{$category.id}" class="category_header active border-double filtered_by_overview_mode">
                  <td colspan="3" class="category_title" style="width:84%">{$category.title}<i class="glyphicon glyphicon-remove"></td>
                </tr>
              {/foreach}
            </tbody>
          </table>
        </div>
        
        <div class="tab-pane no-padding" id="add-category-tab" style="margin-top: 5px;">
          <div class="col-lg-12 add_custom_data_form">
            <div class="category-title">
              <span>Add Custom Category</span>
            </div>
            <!-- add custom header -->
            <div side_bar_control_panel="add_custom_header">
              <!-- Form sample -->
              <br>
              <div class="form-group">
                <label>Category name:</label><br>
                <input type="text" style="height: 35px;" name="headername" class="form-control custom_header_name" placeholder="Category name">
                <label id="with_icon-error" class="validation-error-label add_header_error_msg" for="with_icon">This field is required.</label>
                <label id="with_icon-error" class="validation-error-label duplicate_header_error_msg" for="with_icon">Category already exists.</label>
              </div>
              <div class="form-group hide">
                <label class="display-block">Add to group:</label><br>
                <label class="radio-inline">
                  <input type="radio" class="styled" name="component_group" value="excluded_fields" checked="checked">
                  Included  
                </label>
                <label class="radio-inline">
                  <input type="radio" class="styled" name="component_group" value="included_fields">
                  Excluded
                </label>
              </div>
              <div class="row">
                <div class="col-xs-12">
                  <button class="btn btn-info btn-block create_new_header">Add Category</button>
                </div>
              </div>
              <br>
              <div class="row header_added_success_msg">
                <div class="panel-body bg-success">
                  Header Added Success
                </div>
              </div>
            </div>
            <!-- /add custom header -->
          </div>
        </div>
        <!--end add-category-tab-->

        <div class="tab-pane no-padding" id="add-field-tab" style="margin-top: 5px;">
          <div class="col-lg-12 add_custom_data_form">
            <div class="category-title">
              <span>Add Custom Field</span>
            </div>
            <!-- add custom field -->
            <br>
            <div side_bar_control_panel="add_custom_field">
              <div class="form-group">
                <label>Field name:</label><br>
                <input type="text" style="height: 35px;" class="form-control custom_field_name" placeholder="Field name">
                <label id="with_icon-error" class="validation-error-label add_field_error_msg" for="with_icon">This field is required.</label>
                <label id="with_icon-error" class="validation-error-label duplicate_field_error_msg" for="with_icon">Field already exist.</label>
              </div>
              
              <div class="form-group">
                <label>Category:</label><br>
                <select class="select custom_field_category_select"></select>
              </div>
              
              <div class="form-group">
                <label>Field type:</label><br>
                <select class="select custom_field_type_select">
                  <option value="Textarea">Textbox</option>
                  {if $request.word_doc neq 'true'}
                  <option value="Attached Files">File Attachment</option>
                  <option value="Selectbox">Selectbox</option>
                  <option value="Numeric">Numeric</option>
                  <option value="Date">Date</option>
                  {/if}
                </select>
                
                <!-- additional option for field -->
                <div class="additional_add_field_option">
                  <div class="checkbox checkbox-switchery switchery-xs custom_field_include_analysis">
                    <label>
                      <input type="checkbox" class="switchery numeric_field_analysis" value="analysis">
                      Analysis
                    </label>
                  </div>
                  <div class="custom_field_select_option">
                    <div class="custom_field_option_container">
                      <div class="input-group">
                        <input type="text" class="form-control custom_field_option" placeholder="Selectbox option">
                        <span class="input-group-addon" title="Remove this option">&nbsp;&nbsp;&nbsp;&nbsp;</span>
                      </div>
                    </div>
                    <label id="with_icon-error" class="validation-error-label custom_selectbox_options" for="with_icon">Selectbox option empty.</label>
                    <a class="custom_field_add_option_link">Add selectbox option</a>
                  </div>
                </div>
              </div>
              
              <div class="form-group hide">
                <label class="display-block">Add to group:</label>
                <label class="radio-inline">
                  <input type="radio" class="styled" name="field_component_group" value="excluded_fields" checked="checked">
                  Included
                </label>
                <label class="radio-inline">
                  <input type="radio" class="styled" name="field_component_group" value="included_fields">
                  Excluded
                </label>
              </div>
              <div class="row">
                <div class="col-xs-12">
                  <button type="submit" class="btn bg-teal-300 btn-block create_new_field">Add field</button>
                </div>
              </div>
              <br>
              <div class="row field_added_success_msg">
                <div class="panel-body bg-success">
                  Field Added Success
                </div>
              </div>
            </div>
            <!-- /add custom field -->
          </div>
        </div>
        <!--end add-field-tab-->
      </div>
    </div>
  </div>
</div>
<!-- /secondary sidebar -->