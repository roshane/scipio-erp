<#--
* 
* Individual field widgets HTML template include, default Cato markup.
*
* Included by htmlForm.ftl.
*
* NOTE: May have implicit dependencies on other parts of Cato API.
*
-->

<#-- 
TODO: the parameters on these should be refined to be less ofbiz-like and more cato-like; but must
    be flexible enough to 100% allow calls from ofbiz widget lib macros.
TODO: _markup_widget macros should be cleaned up and logic moved to _widget macros -->

<#-- migrated from @renderClass form widget macro -->
<#macro fieldClassStr classes alert=false>
  <#if classes?has_content || alert?string == "true"> class="${classes!}<#if alert?string == "true"> alert</#if>"</#if><#t>
</#macro>

<#-- migrated from @renderSubmitFieldAreaProgress form widget macro -->
<#macro fieldSubmitAreaProgress progressOptions nestedContent=true>
  <#if !nestedContent?is_string>
    <#if nestedContent?is_boolean && nestedContent == false>
      <#local nestedContent = "">
    <#else>
      <#local nestedContent><#nested></#local>
    </#if>
  </#if>

  <#local rowClass>submit-progress-row<#if buttonMarkup?has_content> has-submit-button<#else> no-submit-button</#if></#local>
  <@row class=("+" + rowClass)>
    <#if nestedContent?has_content>
      <@cell class="${styles.grid_small!}3 ${styles.grid_large!}2">
        ${nestedContent}
      </@cell>
    </#if>
    <#if progressOptions.progBarId?has_content>
      <#-- with progress bar, optional text -->
      <#local subclasses = progressOptions.progTextBoxId?has_content?string("${styles.grid_small!}6 ${styles.grid_large!}6", "${styles.grid_small!}9 ${styles.grid_large!}10 ${styles.grid_end!}")>
      <@cell class=subclasses>
        <@progress id=progressOptions.progBarId type="info" containerClass="+${styles.hidden!}" progressOptions=progressOptions/>
      </@cell>
      <#if progressOptions.progTextBoxId?has_content>
        <#local subclasses = "${styles.grid_small!}3 ${styles.grid_large!}4 ${styles.grid_end!}">
        <@cell class=subclasses id=progressOptions.progTextBoxId>
        </@cell>
      </#if>
    <#elseif progressOptions.progTextBoxId?has_content>
       <#-- text progress only -->
       <#local subclasses = "${styles.grid_small!}9 ${styles.grid_large!}10 ${styles.grid_end!}">
       <@cell class=subclasses id=progressOptions.progTextBoxId>
       </@cell>
       <@progressScript options=progressOptions htmlwrap=true />
    </#if>
  </@row>
</#macro>

<#-- migrated from @renderTextField form widget macro -->
<#macro field_input_widget name="" classes="" alert="" value="" textSize="" maxlength="" id="" event="" action="" disabled=false ajaxUrl="" ajaxEnabled=false 
    mask=false clientAutocomplete="" placeholder="" tooltip="" collapse=false readonly=false fieldTitleBlank=false>
  <@field_input_markup_widget name=name classes=classes alert=alert value=value textSize=textSize maxlength=maxlength id=id event=event action=action disabled=disabled ajaxUrl=ajaxUrl ajaxEnabled=ajaxEnabled 
    mask=mask clientAutocomplete=clientAutocomplete placeholder=placeholder tooltip=tooltip collapse=collapse readonly=readonly fieldTitleBlank=fieldTitleBlank><#nested></@field_input_markup_widget>
</#macro>

<#-- field markup - may be overridden -->
<#macro field_input_markup_widget name="" classes="" alert="" value="" textSize="" maxlength="" id="" event="" action="" disabled=false ajaxUrl="" ajaxEnabled=false 
    mask=false clientAutocomplete="" placeholder="" tooltip="" collapse=false readonly=false fieldTitleBlank=false extraArgs...>
  <#if tooltip?has_content> 
     <#local classes = (classes + " has-tip tip-right")/>  
  </#if>
  <#if mask?has_content && mask>
    <script type="text/javascript">
      jQuery(function($){jQuery("#${id}").mask("${mask!}");});
    </script>
  </#if>
  <input type="text" name="${name?default("")?html}"<#t/>
    <#if tooltip?has_content> 
     data-tooltip aria-haspopup="true" data-options="disable_for_touch:true" title="${tooltip!}"<#rt/>
     </#if><#rt/>
    <@fieldClassStr classes=classes alert=alert />
    <#if value?has_content> value="${value}"</#if><#rt/>
    <#if textSize?has_content> size="${textSize}"</#if><#rt/>
    <#if maxlength?has_content> maxlength="${maxlength}"</#if><#rt/>
    <#if disabled?has_content && disabled> disabled="disabled"</#if><#rt/>
    <#if readonly?has_content && readonly> readonly="readonly"</#if><#rt/>
    <#if id?has_content> id="${id}"</#if><#rt/>
    <#if event?has_content && action?has_content> ${event}="${action}"</#if><#rt/>
    <#if clientAutocomplete?has_content && clientAutocomplete=="false"> autocomplete="off"</#if><#rt/>
    <#if placeholder?has_content> placeholder="${placeholder}"</#if><#rt/>
  /><#t/>
  <#if ajaxUrl?has_content>
    <#local defaultMinLength = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("widget.properties", "widget.autocompleter.defaultMinLength")>
    <#local defaultDelay = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("widget.properties", "widget.autocompleter.defaultDelay")>
    <script language="JavaScript" type="text/javascript">ajaxAutoCompleter('${ajaxUrl}', false, ${defaultMinLength!2}, ${defaultDelay!300});</script><#lt/>
  </#if>
</#macro>

<#-- migrated from @renderTextareaField form widget macro -->
<#macro field_textarea_widget name="" classes="" alert="" cols="" rows="" id="" readonly="" value="" visualEditorEnable=true 
    buttons="" language="" placeholder="" tooltip="" title="" fieldTitleBlank=false collapse=false>
  <@field_textarea_markup_widget name=name classes=classes alert=alert cols=cols rows=rows id=id readonly=readonly value=value visualEditorEnable=visualEditorEnable 
    buttons=buttons language=language placeholder=placeholder tooltip=tooltip title=title fieldTitleBlank=fieldTitleBlank collapse=collapse><#nested></@field_textarea_markup_widget>
</#macro>

<#-- field markup - may be overridden -->
<#macro field_textarea_markup_widget name="" classes="" alert="" cols="" rows="" id="" readonly="" value="" visualEditorEnable=true 
    buttons="" language="" placeholder="" tooltip="" title="" fieldTitleBlank=false collapse=false extraArgs...>
  <#if tooltip?has_content> 
     <#local classes = (classes+ " has-tip tip-right")/>  
  </#if>
  <textarea name="${name}"<#t/>
    <#if tooltip?has_content> data-tooltip aria-haspopup="true" data-options="disable_for_touch:true" title="${tooltip!}"</#if><#rt/>
    <@fieldClassStr classes=classes alert=alert />
    <#if cols?has_content> cols="${cols}"</#if><#rt/>
    <#if rows?has_content> rows="${rows}"</#if><#rt/>
    <#if id?has_content> id="${id}"</#if><#rt/>
    <#if (readonly?is_string && readonly?has_content) || (readonly?is_boolean && readonly == true)> readonly="readonly"</#if><#rt/>
    <#if maxlength?has_content> maxlength="${maxlength}"</#if><#rt/>
    <#if placeholder?has_content> placeholder="${placeholder}"</#if><#t/>
    ><#t/>
    <#if value?has_content>${value}<#else><#nested></#if><#t>
  </textarea><#lt/>
  
  <#--
  ToDo: Remove
  <#if visualEditorEnable?has_content>
    <script language="javascript" src="/images/jquery/plugins/elrte-1.3/js/elrte.min.js" type="text/javascript"></script><#rt/>
    <#if language?has_content && language != "en">
      <script language="javascript" src="/images/jquery/plugins/elrte-1.3/js/i18n/elrte.${language!"en"}.js" type="text/javascript"></script><#rt/>
    </#if>
    <link href="/images/jquery/plugins/elrte-1.3/css/elrte.min.css" rel="stylesheet" type="text/css">
    <script language="javascript" type="text/javascript">
      var opts = {
         cssClass : 'el-rte',
         lang     : '${language!"en"}',
         toolbar  : '${buttons?default("maxi")}',
         doctype  : '<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">', //'<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN">',
         cssfiles : ['/images/jquery/plugins/elrte-1.3/css/elrte-inner.css']
      }
      jQuery('#${id?default("")}').elrte(opts);
    </script>
  </#if>
  -->
</#macro>

<#-- migrated from @renderDateTimeField form widget macro -->
<#macro field_datetime_widget name="" classes="" title="" value="" size="" maxlength="" id="" dateType="" shortDateInput=false 
    timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" 
    hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName="" 
    alert=false mask="" event="" action="" step="" timeValues="" tooltip="" collapse=false fieldTitleBlank=false>
  <@field_datetime_markup_widget name=name classes=classes title=title value=value size=size maxlength=maxlength id=id dateType=dateType shortDateInput=shortDateInput 
    timeDropdownParamName=timeDropdownParamName defaultDateTimeString=defaultDateTimeString localizedIconTitle=localizedIconTitle timeDropdown=timeDropdown timeHourName=timeHourName classString=classString 
    hour1=hour1 hour2=hour2 timeMinutesName=timeMinutesName minutes=minutes isTwelveHour=isTwelveHour ampmName=ampmName amSelected=amSelected pmSelected=pmSelected compositeType=compositeType formName=formName 
    alert=alert mask=mask event=event action=action step=step timeValues=timeValues tooltip=tooltip collapse=false fieldTitleBlank=fieldTitleBlank><#nested></@field_datetime_markup_widget>
</#macro>

<#-- field markup - may be overridden -->
<#macro field_datetime_markup_widget name="" classes="" title="" value="" size="" maxlength="" id="" dateType="" shortDateInput=false 
    timeDropdownParamName="" defaultDateTimeString="" localizedIconTitle="" timeDropdown="" timeHourName="" classString="" 
    hour1="" hour2="" timeMinutesName="" minutes="" isTwelveHour="" ampmName="" amSelected="" pmSelected="" compositeType="" formName="" 
    alert=false mask="" event="" action="" step="" timeValues="" tooltip="" collapse=false fieldTitleBlank=false extraArgs...>
  
  <#local fdatepickerOptions>{format:"yyyy-mm-dd", forceParse:false}</#local>
  <#-- Note: ofbiz never handled dateType=="date" here because it pass shortDateInput=true in renderer instead-->
  <#-- These should be ~uiLabelMap.CommonFormatDate/Time/DateTime -->
  <#local dateFormat><#if (shortDateInput!false) == true>yyyy-MM-dd<#elseif dateType=="time">HH:mm:ss.SSS<#else>yyyy-MM-dd HH:mm:ss.SSS</#if></#local>
  <#local useTsFormat = (((shortDateInput!false) == false) && dateType!="time")>

  <div class="${styles.grid_row!} ${styles.collapse!} date" data-date="" data-date-format="${dateFormat}">
        <div class="${styles.grid_small!}11 ${styles.grid_cell!}">
          <#if dateType == "time">
            <input type="text" name="${name}"<@fieldClassStr classes=classes alert=alert /><#rt/>
            <#if tooltip?has_content> data-tooltip aria-haspopup="true" class="has-tip tip-right" data-options="disable_for_touch:true" title="${tooltip!}"</#if><#rt/>
            <#if title?has_content> title="${title}"</#if>
            <#if value?has_content> value="${value}"</#if>
            <#if size?has_content> size="${size}"</#if><#rt/>
            <#if maxlength?has_content>  maxlength="${maxlength}"</#if>
            <#if id?has_content> id="${id}"</#if> class="${styles.grid_small!}3 ${styles.grid_cell!}"/><#rt/>
          <#else>
            <input type="text" name="${name}_i18n"<@fieldClassStr classes=classes alert=alert /><#rt/>
            <#if tooltip?has_content> data-tooltip aria-haspopup="true" class="has-tip tip-right" data-options="disable_for_touch:true" title="${tooltip!}"</#if><#rt/>
            <#if title?has_content> title="${title}"</#if>
            <#if value?has_content> value="${value}"</#if>
            <#if size?has_content> size="${size}"</#if><#rt/>
            <#if maxlength?has_content>  maxlength="${maxlength}"</#if>
            <#if id?has_content> id="${id}_i18n"</#if> class="${styles.grid_small!}3 ${styles.grid_cell!}"/><#rt/>

            <input type="hidden" name="${name}"<#if id?has_content> id="${id}"</#if><#if value?has_content> value="${value}"</#if> />
          </#if>
        </div>
        <div class="${styles.grid_small!}1 ${styles.grid_cell!}">
        <span class="postfix"><i class="${styles.icon!} ${styles.icon_calendar!}"></i></span>
        </div>
      <#if dateType != "time">
        <script type="text/javascript">
            $(function() {

                var dateI18nToNorm = function(date) {
                    <#-- TODO (note: depends on dateType) -->
                    return date;
                };
                
                var dateNormToI18n = function(date) {
                    <#-- TODO (note: depends on dateType) -->
                    return date;
                };
            
                jQuery("#${id}_i18n").change(function() {
                    jQuery("#${id}").val(dateI18nToNorm(this.value));
                });
                
                var oldDate = "";
                var onFDatePopup = function(ev) {
                    oldDate = dateI18nToNorm(jQuery("#${id}_i18n").val());
                };
                var onFDateChange = function(ev) {
                  <#if useTsFormat>
                    jQuery("#${id}_i18n").val(dateNormToI18n(convertToDateTimeNorm(dateI18nToNorm(jQuery("#${id}_i18n").val()), oldDate)));
                  </#if>
                };
                
                <#if name??>
                    <#local dateElemJs>$("input[name='${name?html}_i18n']")</#local>
                <#else>
                    <#local dateElemJs>$("input")</#local>
                </#if>
                ${dateElemJs}.fdatepicker(${fdatepickerOptions}).on('changeDate', onFDateChange).on('show', onFDatePopup);
            });
        </script>
      </#if>
  </div>
</#macro>

<#-- migrated from @renderDateFindField form widget macro -->
<#macro field_datefind_widget classes="" alert="" name="" localizedInputTitle="" value="" value2="" size="" maxlength="" dateType="" 
    formName="" defaultDateTimeString="" imgSrc="" localizedIconTitle="" titleStyle="" defaultOptionFrom="" defaultOptionThru="" 
    opEquals="" opSameDay="" opGreaterThanFromDayStart="" opGreaterThan="" opGreaterThan="" opLessThan="" opUpToDay="" opUpThruDay="" opIsEmpty="">
  <@field_datefind_markup_widget classes=classes alert=alert name=name localizedInputTitle=localizedInputTitle value=value value2=value2 size=size maxlength=maxlength dateType=dateType 
    formName=formName defaultDateTimeString=defaultDateTimeString imgSrc=imgSrc localizedIconTitle=localizedIconTitle titleStyle=titleStyle defaultOptionFrom=defaultOptionFrom defaultOptionThru=defaultOptionThru 
    opEquals=opEquals opSameDay=opSameDay opGreaterThanFromDayStart=opGreaterThanFromDayStart opGreaterThan=opGreaterThan opGreaterThan=opGreaterThan opLessThan=opLessThan opUpToDay=opUpToDay opUpThruDay=opUpThruDay opIsEmpty=opIsEmpty><#nested></@field_datefind_markup_widget>
</#macro>

<#-- field markup - may be overridden -->
<#macro field_datefind_markup_widget classes="" alert="" name="" localizedInputTitle="" value="" value2="" size="" maxlength="" dateType="" 
    formName="" defaultDateTimeString="" imgSrc="" localizedIconTitle="" titleStyle="" defaultOptionFrom="" defaultOptionThru="" 
    opEquals="" opSameDay="" opGreaterThanFromDayStart="" opGreaterThan="" opGreaterThan="" opLessThan="" opUpToDay="" opUpThruDay="" opIsEmpty="" extraArgs...>

  <#local fdatepickerOptions>{format:"yyyy-mm-dd", forceParse:false}</#local>
  <#-- note: values of localizedInputTitle are: uiLabelMap.CommonFormatDate/Time/DateTime -->
  <#local dateFormat><#if dateType == "date">yyyy-MM-dd<#elseif dateType=="time">HH:mm:ss.SSS<#else>yyyy-MM-dd HH:mm:ss.SSS</#if></#local>
  <#local useTsFormat = (dateType != "date" && dateType != "time")>
  
  <div class="${styles.grid_row!} ${styles.collapse!} date" data-date="" data-date-format="${dateFormat}">
        <div class="${styles.grid_small!}5 ${styles.grid_cell!}">
        <input class="${styles.grid_small!}3 ${styles.grid_cell!}" id="${name?html}_fld0_value" type="text"<@fieldClassStr classes=classes alert=alert /><#if name?has_content> name="${name?html}_fld0_value"</#if><#if localizedInputTitle?has_content> title="${localizedInputTitle}"</#if><#if value?has_content> value="${value}"</#if><#if size?has_content> size="${size}"</#if><#if maxlength?has_content> maxlength="${maxlength}"</#if>/><#rt/>
        </div>
        <div class="${styles.grid_small!}1 ${styles.grid_cell!}">
        <span class="postfix"><i class="${styles.icon} ${styles.icon_calendar!}"></i></span>
        </div>
        <div class="${styles.grid_small!}5 ${styles.grid_cell!} ${styles.grid_small!}offset-1">
        <select<#if name?has_content> name="${name}_fld0_op"</#if> class="selectBox"><#rt/>
          <option value="equals"<#if defaultOptionFrom=="equals"> selected="selected"</#if>>${opEquals}</option><#rt/>
          <option value="sameDay"<#if defaultOptionFrom=="sameDay"> selected="selected"</#if>>${opSameDay}</option><#rt/>
          <option value="greaterThanFromDayStart"<#if defaultOptionFrom=="greaterThanFromDayStart"> selected="selected"</#if>>${opGreaterThanFromDayStart}</option><#rt/>
          <option value="greaterThan"<#if defaultOptionFrom=="greaterThan"> selected="selected"</#if>>${opGreaterThan}</option><#rt/>
        </select><#rt/>
        </div>
      <#if dateType != "time">
        <script type="text/javascript">
            $(function() {
                var oldDate = "";
                var onFDatePopup = function(ev) {
                    oldDate = jQuery("#${name?html}_fld0_value").val();
                };
                var onFDateChange = function(ev) {
                  <#if useTsFormat>
                    jQuery("#${name?html}_fld0_value").val(convertToDateTimeNorm(jQuery("#${name?html}_fld0_value").val(), oldDate));
                  </#if>
                };
            
                <#if name??>
                    <#local dateElemJs>$('#${name?html}_fld0_value')</#local>
                <#else>
                    <#local dateElemJs>$('input')</#local>
                </#if>
                ${dateElemJs}.fdatepicker(${fdatepickerOptions}).on('changeDate', onFDateChange).on('show', onFDatePopup);
            });
        </script>
      </#if>
  </div>
</#macro>

<#-- migrated from @renderDropDownField form widget macro -->
<#macro field_select_widget name="" classes="" alert="" id="" multiple="" formName="" otherFieldName="" size="" firstInList="" 
    currentValue="" explicitDescription="" allowEmpty="" options="" fieldName="" otherFieldName="" otherValue="" otherFieldSize="" 
    dDFCurrent="" noCurrentSelectedKey="" ajaxOptions="" frequency="" minChars="" choices="" autoSelect="" partialSearch="" partialChars="" 
    ignoreCase="" fullSearch="" event="" action="" ajaxEnabled=false tooltip="" manualItems=false manualItemsOnly=false 
    collapse=false fieldTitleBlank=false>
  <@field_select_markup_widget name=name classes=classes alert=alert id=id multiple=multiple formName=formName otherFieldName=otherFieldName size=size firstInList=firstInList 
    currentValue=currentValue explicitDescription=explicitDescription allowEmpty=allowEmpty options=options fieldName=fieldName otherFieldName=otherFieldName otherValue=otherValue otherFieldSize=otherFieldSize 
    dDFCurrent=dDFCurrent noCurrentSelectedKey=noCurrentSelectedKey ajaxOptions=ajaxOptions frequency=frequency minChars=minChars choices=choices autoSelect=autoSelect partialSearch=partialSearch partialChars=partialChars 
    ignoreCase=ignoreCase fullSearch=fullSearch event=event action=action ajaxEnabled=ajaxEnabled tooltip=tooltip manualItems=manualItems manualItemsOnly=manualItemsOnly 
    collapse=collapse fieldTitleBlank=fieldTitleBlank><#nested></@field_select_markup_widget>
</#macro>

<#-- field markup - may be overridden -->
<#macro field_select_markup_widget name="" classes="" alert="" id="" multiple="" formName="" otherFieldName="" size="" firstInList="" 
    currentValue="" explicitDescription="" allowEmpty="" options="" fieldName="" otherFieldName="" otherValue="" otherFieldSize="" 
    dDFCurrent="" noCurrentSelectedKey="" ajaxOptions="" frequency="" minChars="" choices="" autoSelect="" partialSearch="" partialChars="" 
    ignoreCase="" fullSearch="" event="" action="" ajaxEnabled=false tooltip="" manualItems=false manualItemsOnly=false 
    collapse=false fieldTitleBlank=false extraArgs...>

    <select name="${name!""}<#rt/>"<@fieldClassStr classes=classes alert=alert /><#if id?has_content> id="${id}"</#if><#if multiple?has_content> multiple="multiple"</#if><#if otherFieldSize gt 0> onchange="process_choice(this,document.${formName}.${otherFieldName})"</#if><#if event?has_content> ${event}="${action}"</#if><#--<#if size?has_content> size="${size}"</#if>-->
    <#if tooltip?has_content> data-tooltip aria-haspopup="true" class="has-tip tip-right" data-options="disable_for_touch:true" title="${tooltip!}"</#if><#rt/>>
    <#if !manualItemsOnly>  
      <#if firstInList?has_content && currentValue?has_content && !multiple?has_content>
        <option selected="selected" value="${currentValue}">${explicitDescription}</option><#rt/>
        <option value="${currentValue}">---</option><#rt/>
      </#if>
      <#if allowEmpty?has_content || (!manualItems && !options?has_content)>
        <option value="">&nbsp;</option>
      </#if>
      <#list options as item>
        <#if multiple?has_content>
          <option<#if currentValue?has_content && item.selected?has_content> selected="${item.selected}" <#elseif !currentValue?has_content && noCurrentSelectedKey?has_content && noCurrentSelectedKey == item.key> selected="selected" </#if> value="${item.key}">${item.description}</option><#rt/>
        <#else>
          <option<#if currentValue?has_content && currentValue == item.key && dDFCurrent?has_content && "selected" == dDFCurrent> selected="selected"<#elseif !currentValue?has_content && noCurrentSelectedKey?has_content && noCurrentSelectedKey == item.key> selected="selected"</#if> value="${item.key}">${item.description}</option><#rt/>
        </#if>
      </#list>
    </#if>
      <#nested>
    </select>
  <#if otherFieldName?has_content>
    <noscript><input type='text' name='${otherFieldName}' /></noscript>
    <script type='text/javascript' language='JavaScript'><!--
      disa = ' disabled';
      if(other_choice(document.${formName}.${fieldName}))
        disa = '';
      document.write("<input type='text' name='${otherFieldName}' value='${otherValue?js_string}' size='${otherFieldSize}'"+disa+" onfocus='check_choice(document.${formName}.${fieldName})' />");
      if(disa && document.styleSheets)
      document.${formName}.${otherFieldName}.styles.visibility  = 'hidden';
    //--></script>
  </#if>

  <#if ajaxEnabled>
    <script language="JavaScript" type="text/javascript">
      ajaxAutoCompleteDropDown();
      jQuery(function() {
        jQuery("#${id}").combobox();
      });
    </script>
  </#if>
</#macro>

<#-- migrated from @renderLookupField form widget macro -->
<#macro field_lookup_widget name="" formName="" fieldFormName="" classes="" alert="false" value="" size="" 
    maxlength="" id="" event="" action="" readonly=false autocomplete="" descriptionFieldName="" 
    targetParameterIter="" imgSrc="" ajaxUrl="" ajaxEnabled=javaScriptEnabled presentation="layer" width="" 
    height="" position="" fadeBackground="true" clearText="" showDescription="" initiallyCollapsed="" 
    lastViewName="main" title="" fieldTitleBlank=false>
  <@field_lookup_markup_widget name=name formName=formName fieldFormName=fieldFormName classes=classes alert=alert value=value size=size 
    maxlength=maxlength id=id event=event action=action readonly=readonly autocomplete=autocomplete descriptionFieldName=descriptionFieldName 
    targetParameterIter=targetParameterIter imgSrc=imgSrc ajaxUrl=ajaxUrl ajaxEnabled=ajaxEnabled presentation=presentation width=width 
    height=height position=position fadeBackground=fadeBackground clearText=clearText showDescription=showDescription initiallyCollapsed=initiallyCollapsed 
    lastViewName=lastViewName title=title fieldTitleBlank=fieldTitleBlank><#nested></@field_lookup_markup_widget>
</#macro>

<#-- field markup - may be overridden -->
<#macro field_lookup_markup_widget name="" formName="" fieldFormName="" classes="" alert="false" value="" size="" 
    maxlength="" id="" event="" action="" readonly=false autocomplete="" descriptionFieldName="" 
    targetParameterIter="" imgSrc="" ajaxUrl="" ajaxEnabled=javaScriptEnabled presentation="layer" width="" 
    height="" position="" fadeBackground="true" clearText="" showDescription="" initiallyCollapsed="" 
    lastViewName="main" title="" fieldTitleBlank=false extraArgs...>

  <#if Static["org.ofbiz.widget.model.ModelWidget"].widgetBoundaryCommentsEnabled(context)>
  </#if>
  <#if (!ajaxUrl?has_content) && ajaxEnabled?has_content && ajaxEnabled>
    <#local ajaxUrl = requestAttributes._REQUEST_HANDLER_.makeLink(request, response, fieldFormName)/>
    <#local ajaxUrl = id + "," + ajaxUrl + ",ajaxLookup=Y" />
  </#if>
  <#if (!showDescription?has_content)>
    <#local showDescriptionProp = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("widget.properties", "widget.lookup.showDescription", "N")>
    <#if "Y" == showDescriptionProp>
      <#local showDescription = "true" />
    <#else>
      <#local showDescription = "false" />
    </#if>
  </#if>
  <#if ajaxEnabled?has_content && ajaxEnabled>
    <script type="text/javascript">
      jQuery(document).ready(function(){
        if (!jQuery('form[name="${formName}"]').length) {
          alert("Developer: for lookups to work you must provide a form name!")
        }
      });
    </script>
  </#if>
  <span class="field-lookup">
    <#if size?has_content && size=="0">
      <input type="hidden" <#if name?has_content> name="${name}"/></#if>
    <#else>
      <input type="text"<@fieldClassStr classes=classes alert=alert /><#if name?has_content> name="${name}"</#if><#if value?has_content> value="${value}"</#if>
        <#if size?has_content> size="${size}"</#if><#if maxlength?has_content> maxlength="${maxlength}"</#if><#if id?has_content> id="${id}"</#if><#rt/>
        <#if readonly?has_content && readonly> readonly="readonly"</#if><#rt/><#if event?has_content && action?has_content> ${event}="${action}"</#if><#rt/>
        <#if autocomplete?has_content> autocomplete="off"</#if>/><#rt/></#if>
    <#if presentation?has_content && descriptionFieldName?has_content && presentation == "window">
      <a href="javascript:call_fieldlookup3(document.${formName?html}.${name?html},document.${formName?html}.${descriptionFieldName},'${fieldFormName}', '${presentation}'<#rt/>
      <#if targetParameterIter?has_content>
        <#list targetParameterIter as item>
          ,document.${formName}.${item}.value<#rt>
        </#list>
      </#if>
      );"></a><#rt>
    <#elseif presentation?has_content && presentation == "window">
      <a href="javascript:call_fieldlookup2(document.${formName?html}.${name?html},'${fieldFormName}', '${presentation}'<#rt/>
      <#if targetParameterIter?has_content>
        <#list targetParameterIter as item>
          ,document.${formName}.${item}.value<#rt>
        </#list>
      </#if>
      );"></a><#rt>
    <#else>
      <#if ajaxEnabled?has_content && ajaxEnabled>
        <#local defaultMinLength = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("widget.properties", "widget.autocompleter.defaultMinLength")>
        <#local defaultDelay = Static["org.ofbiz.base.util.UtilProperties"].getPropertyValue("widget.properties", "widget.autocompleter.defaultDelay")>
        <#local ajaxUrl = ajaxUrl + "&amp;_LAST_VIEW_NAME_=" + lastViewName />
        <#if !ajaxUrl?contains("searchValueFieldName=")>
          <#if descriptionFieldName?has_content && showDescription == "true">
            <#local ajaxUrl = ajaxUrl + "&amp;searchValueFieldName=" + descriptionFieldName />
          <#else>
            <#local ajaxUrl = ajaxUrl + "&amp;searchValueFieldName=" + name />
          </#if>
        </#if>
      </#if>
      <script type="text/javascript">
        jQuery(document).ready(function(){
          var options = {
            requestUrl : "${fieldFormName}",
            inputFieldId : "${id}",
            dialogTarget : document.${formName?html}.${name?html},
            dialogOptionalTarget : <#if descriptionFieldName?has_content>document.${formName?html}.${descriptionFieldName}<#else>null</#if>,
            formName : "${formName?html}",
            width : "${width}",
            height : "${height}",
            position : "${position}",
            modal : "${fadeBackground}",
            ajaxUrl : <#if ajaxEnabled?has_content && ajaxEnabled>"${ajaxUrl}"<#else>""</#if>,
            showDescription : <#if ajaxEnabled?has_content && ajaxEnabled>"${showDescription}"<#else>false</#if>,
            presentation : "${presentation!}",
            defaultMinLength : "${defaultMinLength!2}",
            defaultDelay : "${defaultDelay!300}",
            args :
              <#rt/>
                <#if targetParameterIter?has_content>
                  <#local isFirst = true>
                  <#lt/>[<#rt/>
                  <#list targetParameterIter as item>
                    <#if isFirst>
                      <#lt/>document.${formName}.${item}<#rt/>
                      <#local isFirst = false>
                    <#else>
                      <#lt/> ,document.${formName}.${item}<#rt/>
                    </#if>
                  </#list>
                  <#lt/>]<#rt/>
                <#else>[]
                </#if>
                <#lt/>
          };
          new Lookup(options).init();
        });
      </script>
    </#if>
    <#if readonly?has_content && readonly>
      <a id="${id}_clear" 
        style="background:none;margin-left:5px;margin-right:15px;" 
        class="clearField" 
        href="javascript:void(0);" 
        onclick="javascript:document.${formName}.${name}.value='';
          jQuery('#' + jQuery('#${id}_clear').next().attr('id').replace('_button','') + '_${id}_lookupDescription').html('');
          <#if descriptionFieldName?has_content>document.${formName}.${descriptionFieldName}.value='';</#if>">
          <#if clearText?has_content>${clearText}<#else>${uiLabelMap.CommonClear}</#if>
      </a>
    </#if>
  </span>
  <#if ajaxEnabled?has_content && ajaxEnabled && (presentation?has_content && presentation == "window")>
    <#if ajaxUrl?index_of("_LAST_VIEW_NAME_") < 0>
      <#local ajaxUrl = ajaxUrl + "&amp;_LAST_VIEW_NAME_=" + lastViewName />
    </#if>
    <script language="JavaScript" type="text/javascript">ajaxAutoCompleter('${ajaxUrl}', ${showDescription}, ${defaultMinLength!2}, ${defaultDelay!300});</script><#t/>
  </#if>
</#macro>

<#-- migrated from @renderCheckBox form widget macro -->
<#macro field_checkbox_widget id="" checked=false currentValue="N" name="" action="" tooltip="" fieldTitleBlank=false>
  <@field_checkbox_markup_widget id=id checked=checked currentValue=currentValue name=name action=action tooltip=tooltip fieldTitleBlank=fieldTitleBlank><#nested></@field_checkbox_markup_widget>
</#macro>

<#-- field markup - may be overridden -->
<#macro field_checkbox_markup_widget id="" checked=false currentValue="N" name="" action="" tooltip="" fieldTitleBlank=false extraArgs...>
    <div class="switch small">
    <input type="checkbox" id="<#if id?has_content>${id}<#else>${name!}</#if>"<#rt/>
      <#if tooltip?has_content> data-tooltip aria-haspopup="true" class="has-tip tip-right" data-options="disable_for_touch:true" title="${tooltip!}"</#if><#rt/>
      <#if (checked?is_boolean && checked) || (checked?is_string && checked == "Y")> checked="checked"
      <#elseif currentValue?has_content && currentValue=="Y"> checked="checked"</#if> 
      name="${name!""?html}" value="${currentValue!}"<#if action?has_content> onClick="${action}"</#if>/><#rt/>
      <label for="<#if id?has_content>${id}<#else>${name!}</#if>"></label>
    </div>
</#macro>

<#-- migrated from @renderRadioField form widget macro -->
<#macro field_radio_widget items="" classes="" alert="" currentValue="" noCurrentSelectedKey="" name="" event="" action="" tooltip="" multiMode=true inlineItems="">
  <#if !inlineItems?is_boolean>
    <#if inlineItems?has_content>
      <#-- do conversion to boolean so markup doesn't have to; but don't impose a default -->
      <#local inlineItems = inlineItems?boolean>
    </#if>
  </#if>
  <@field_radio_markup_widget items=items classes=classes alert=alert currentValue=currentValue noCurrentSelectedKey=noCurrentSelectedKey name=name 
    event=event action=action tooltip=tooltip multiMode=multiMode inlineItems=inlineItems><#nested></@field_radio_markup_widget>
</#macro>

<#-- field markup - may be overridden -->
<#macro field_radio_markup_widget items="" classes="" alert="" currentValue="" noCurrentSelectedKey="" name="" event="" action="" tooltip="" multiMode=true inlineItems="" extraArgs...>
  <#if !inlineItems?is_boolean>
    <#local inlineItems = true>
  </#if>

  <#if multiMode>
    <div<@fieldClassStr classes=classes alert=alert />>
    <#local classes = ""> <#-- in multi mode, classes only on parent for now (?) -->
  </#if>
  <#if inlineItems>
    <#local classes = joinStyleNames(classes, "radio-item-inline")>
  <#else>
    <#local classes = joinStyleNames(classes, "radio-item-noninline")>
  </#if>
  <#list items as item>
    <span<@fieldClassStr classes=classes alert=alert />><#rt/>
      <input type="radio"<#if currentValue?has_content><#if currentValue==item.key> checked="checked"</#if>
        <#if tooltip?has_content> data-tooltip aria-haspopup="true" class="has-tip tip-right" data-options="disable_for_touch:true" title="${tooltip!}"</#if><#rt/>
        <#elseif noCurrentSelectedKey?has_content && noCurrentSelectedKey == item.key> checked="checked"</#if> 
        name="${name!""?html}" value="${item.key!""?html}"<#if item.event?has_content> ${item.event}="${item.action!}"<#elseif event?has_content> ${event}="${action!}"</#if>/><#rt/>
      ${item.description}
      <br class="radio-item-separator" /> <#-- controlled via css with display:none; TODO? maybe there's a better way -->
    </span>
  </#list>
  <#if multiMode>
    </div>
  </#if>  
</#macro>

<#-- migrated from @renderFileField form widget macro -->
<#macro field_file_widget classes="" alert="" name="" value="" size="" maxlength="" autocomplete="" id="" title="" fieldTitleBlank=false>
  <@field_file_markup_widget classes=classes alert=alert name=name value=value size=size maxlength=maxlength autocomplete=autocomplete id=id title=title fieldTitleBlank=fieldTitleBlank><#nested></@field_file_markup_widget>
</#macro>

<#-- field markup - may be overridden -->
<#macro field_file_markup_widget classes="" alert="" name="" value="" size="" maxlength="" autocomplete="" id="" title="" fieldTitleBlank=false extraArgs...>
  <input type="file"<@fieldClassStr classes=classes alert=alert /><#if id?has_content> id="${id}"</#if><#if name?has_content> name="${name}"</#if><#if value?has_content> value="${value}"</#if><#if size?has_content> size="${size}"</#if><#if maxlength?has_content> maxlength="${maxlength}"</#if><#if autocomplete?has_content> autocomplete="off"</#if>/><#rt/>
</#macro>

<#-- migrated from @renderPasswordField form widget macro -->
<#macro field_password_widget classes="" alert="" name="" value="" size="" maxlength="" id="" autocomplete="" title="" placeholder="" fieldTitleBlank=false tooltip="">
  <@field_password_markup_widget classes=classes alert=alert name=name value=value size=size maxlength=maxlength id=id autocomplete=autocomplete title=title placeholder=placeholder fieldTitleBlank=fieldTitleBlank tooltip=tooltip><#nested></@field_password_markup_widget>
</#macro>

<#-- field markup - may be overridden -->
<#macro field_password_markup_widget classes="" alert="" name="" value="" size="" maxlength="" id="" autocomplete="" title="" placeholder="" fieldTitleBlank=false tooltip="" extraArgs...>
  <#if tooltip?has_content> 
     <#local classes = (classes+ " has-tip tip-right")/>  
  </#if> 
  <input type="password"<@fieldClassStr classes=classes alert=alert /><#if name?has_content> name="${name}"</#if><#if value?has_content> value="${value}"</#if><#if size?has_content> size="${size}"</#if>
  <#if maxlength?has_content> maxlength="${maxlength}"</#if><#if id?has_content> id="${id}"</#if><#if autocomplete?has_content> autocomplete="off"</#if> 
  <#if placeholder?has_content> placeholder="${placeholder}"</#if>
  <#if tooltip?has_content> data-tooltip aria-haspopup="true" data-options="disable_for_touch:true" title="${tooltip!}"</#if><#rt/>
  <#if classes?has_content> class="${classes}"</#if><#rt/>/>
</#macro>

<#-- migrated from @renderSubmitField form widget macro -->
<#macro field_submit_widget buttonType="" classes="" alert="" formName="" name="" event="" action="" imgSrc="" confirmation="" 
    containerId="" ajaxUrl="" title="" fieldTitleBlank=false showProgress="" href="" onClick="" inputType="" disabled=false progressOptions={}>
  <@field_submit_markup_widget buttonType=buttonType classes=classes alert=alert formName=formName name=name event=event action=action imgSrc=imgSrc confirmation=confirmation 
    containerId=containerId ajaxUrl=ajaxUrl title=title fieldTitleBlank=fieldTitleBlank showProgress=showProgress href=href onClick=onClick inputType=inputType disabled=disabled progressOptions=progressOptions><#nested></@field_submit_markup_widget>
</#macro>

<#-- field markup - may be overridden -->
<#macro field_submit_markup_widget buttonType="" classes="" alert="" formName="" name="" event="" action="" imgSrc="" confirmation="" 
    containerId="" ajaxUrl="" title="" fieldTitleBlank=false showProgress="" href="" onClick="" inputType="" disabled=false progressOptions={} extraArgs...>
  <#-- Cato: FIXME?: factor out default submit class somewhere so configurable -->
  <#if buttonType!="image">
    <#if !classes?has_content || classes=="smallSubmit">
      <#local classes = "${styles.button_default!}">
    </#if>
  </#if>

  <#-- Cato: to omit button (show progress only), we use empty title hack " " similar to what ofbiz does with hyperlinks with no label -->
  <#if (buttonType=="text-link" || buttonType!="image") && !(title?trim?has_content)>
    <#local buttonMarkup = "">
  <#else>
    <#local buttonMarkup>
      <#if buttonType=="text-link">
        <a<@fieldClassStr classes=classes alert=alert />href="<#if href?has_content>${href}<#elseif formName?has_content>javascript:document.${formName}.submit()<#else>javascript:void(0)</#if>"<#if disabled> disabled="disabled"<#else><#if onClick?has_content> onclick="${onClick}"<#elseif confirmation?has_content> onclick="return confirm('${confirmation?js_string}');"</#if></#if>><#if title?has_content>${title}</#if></a>
      <#elseif buttonType=="image">
        <input type="<#if inputType?has_content>${inputType}<#else>image</#if>" src="${imgSrc}"<@fieldClassStr classes=classes alert=alert /><#if name?has_content> name="${name}"</#if>
        <#if title?has_content> alt="${title}"</#if><#if event?has_content> ${event}="${action}"</#if>
        <#if disabled> disabled="disabled"<#else>
          <#if onClick?has_content> onclick="${onClick}"<#elseif confirmation?has_content>onclick="return confirm('${confirmation?js_string}');"</#if>
        </#if>/>
      <#else>
        <input type="<#if inputType?has_content>${inputType}<#elseif containerId?has_content>button<#else>submit</#if>"<@fieldClassStr classes=classes alert=alert />
        <#if name?has_content> name="${name}"</#if><#if title?has_content> value="${title}"</#if><#if event?has_content> ${event}="${action}"</#if>
        <#if disabled> disabled="disabled"<#else>
          <#if onClick?has_content> onclick="${onClick}"<#else>
            <#if containerId?has_content> onclick="<#if confirmation?has_content>if (confirm('${confirmation?js_string}')) </#if>ajaxSubmitFormUpdateAreas('${containerId}', '${ajaxUrl}')"<#else>
            <#if confirmation?has_content> onclick="return confirm('${confirmation?js_string}');"</#if>
            </#if>
          </#if>
        </#if>/>
      </#if>
    </#local>
  </#if>
  <#if progressOptions?has_content>
      <@fieldSubmitAreaProgress progressOptions=progressOptions nestedContent=buttonMarkup />
  <#else>
      ${buttonMarkup}
  </#if>
</#macro>

<#-- migrated from @renderRangeFindField form widget macro -->
<#macro field_textfind_widget name="" value="" defaultOption="" opEquals="" opBeginsWith="" opContains="" 
    opIsEmpty="" opNotEqual="" classes="" alert="" size="" maxlength="" autocomplete="" titleStyle="" 
    hideIgnoreCase="" ignCase="" ignoreCase="" title="" fieldTitleBlank=false>
  <@field_textfind_markup_widget name=name value=value defaultOption=defaultOption opEquals=opEquals opBeginsWith=opBeginsWith opContains=opContains 
    opIsEmpty=opIsEmpty opNotEqual=opNotEqual classes=classes alert=alert size=size maxlength=maxlength autocomplete=autocomplete titleStyle=titleStyle 
    hideIgnoreCase=hideIgnoreCase ignCase=ignCase ignoreCase=ignoreCase title=title fieldTitleBlank=fieldTitleBlank><#nested></@field_textfind_markup_widget>
</#macro>

<#-- field markup - may be overridden -->
<#macro field_textfind_markup_widget name="" value="" defaultOption="" opEquals="" opBeginsWith="" opContains="" 
    opIsEmpty="" opNotEqual="" classes="" alert="" size="" maxlength="" autocomplete="" titleStyle="" 
    hideIgnoreCase="" ignCase="" ignoreCase="" title="" fieldTitleBlank=false extraArgs...>

  <@row collapse=collapse!false>
    <#if opEquals?has_content>
      <#local class1="${styles.grid_small!}3 ${styles.grid_large!}3"/>
      <#local class2="${styles.grid_small!}6 ${styles.grid_large!}6"/>
      <#local class3="${styles.grid_small!}3 ${styles.grid_large!}3"/>  
    <#else>
      <#local class1=""/>
      <#local class2="${styles.grid_small!}9 ${styles.grid_large!}9"/>
      <#local class3="${styles.grid_small!}3 ${styles.grid_large!}3"/>
    </#if>      
    <#if opEquals?has_content>
      <#local newName = "${name}"/>
      <@cell class="${class1!}">
        <select<#if name?has_content> name="${name}_op"</#if> class="selectBox"><#rt/>
            <option value="equals"<#if defaultOption=="equals"> selected="selected"</#if>>${opEquals}</option><#rt/>
            <option value="like"<#if defaultOption=="like"> selected="selected"</#if>>${opBeginsWith}</option><#rt/>
            <option value="contains"<#if defaultOption=="contains"> selected="selected"</#if>>${opContains}</option><#rt/>
            <option value="empty"<#rt/><#if defaultOption=="empty"> selected="selected"</#if>>${opIsEmpty}</option><#rt/>
            <option value="notEqual"<#if defaultOption=="notEqual"> selected="selected"</#if>>${opNotEqual}</option><#rt/>
        </select>
      </@cell>
    <#else>
      <input type="hidden"<#if name?has_content> name="${name}_op"</#if> value="${defaultOption}"/><#rt/>
    </#if>
      <@cell class="${class2!}">
        <input type="text"<@fieldClassStr classes=classes alert=alert />name="${name}"<#if value?has_content> value="${value}"</#if><#if size?has_content> size="${size}"</#if><#if maxlength?has_content> maxlength="${maxlength}"</#if><#if autocomplete?has_content> autocomplete="off"</#if>/><#rt/>
      </@cell>
      <@cell class="${class3!}"> 
        <#if hideIgnoreCase>
          <input type="hidden" name="${name}_ic" value=<#if ignCase>"Y"<#else> ""</#if>/><#rt/>
        <#else>
          <div>
            <label for="${name}_ic"><input type="checkbox" id="${name}_ic" name="${name}_ic" value="Y"<#if ignCase> checked="checked"</#if>/>
            ${ignoreCase!}</label>
            <#rt/>
          </div>
        </#if>
      </@cell>
  </@row>
</#macro>

<#-- migrated from @renderRangeFindField form widget macro -->
<#macro field_rangefind_widget classes="" alert="" name="" value="" size="" maxlength="" autocomplete="" titleStyle="" defaultOptionFrom="" opEquals="" opGreaterThan="" opGreaterThanEquals="" opLessThan="" opLessThanEquals="" value2="" defaultOptionThru="">
  <@field_rangefind_markup_widget classes=classes alert=alert name=name value=value size=size maxlength=maxlength autocomplete=autocomplete titleStyle=titleStyle defaultOptionFrom=defaultOptionFrom opEquals=opEquals opGreaterThan=opGreaterThan opGreaterThanEquals=opGreaterThanEquals opLessThan=opLessThan opLessThanEquals=opLessThanEquals value2=value2 defaultOptionThru=defaultOptionThru><#nested></@field_rangefind_markup_widget>
</#macro>

<#-- field markup - may be overridden -->
<#macro field_rangefind_markup_widget classes="" alert="" name="" value="" size="" maxlength="" autocomplete="" titleStyle="" defaultOptionFrom="" opEquals="" opGreaterThan="" opGreaterThanEquals="" opLessThan="" opLessThanEquals="" value2="" defaultOptionThru="" extraArgs...>
  <#local class1="${styles.grid_small!}9 ${styles.grid_large!}9"/>
  <#local class2="${styles.grid_small!}3 ${styles.grid_large!}3"/>
  <@row collapse=collapse!false>
    <@cell class=class1>
      <input type="text"<@fieldClassStr classes=classes alert=alert /><#if name?has_content>name="${name}_fld0_value"</#if><#if value?has_content> value="${value}"</#if><#if size?has_content> size="${size}"</#if><#if maxlength?has_content> maxlength="${maxlength}"</#if><#if autocomplete?has_content> autocomplete="off"</#if>/><#rt/>
    </@cell>
    <@cell class=class2>
      <#if titleStyle?has_content>
        <span class="${titleStyle}"><#rt/>
      </#if>
      <select<#if name?has_content> name="${name}_fld0_op"</#if> class="selectBox"><#rt/>
        <option value="equals"<#if defaultOptionFrom=="equals"> selected="selected"</#if>>${opEquals}</option><#rt/>
        <option value="greaterThan"<#if defaultOptionFrom=="greaterThan"> selected="selected"</#if>>${opGreaterThan}</option><#rt/>
        <option value="greaterThanEqualTo"<#if defaultOptionFrom=="greaterThanEqualTo"> selected="selected"</#if>>${opGreaterThanEquals}</option><#rt/>
      </select><#rt/>
      <#if titleStyle?has_content>
        </span><#rt/>
      </#if>
    </@cell>
  </@row><#rt/>
  <@row>
    <@cell class=class1>
      <input type="text"<@fieldClassStr classes=classes alert=alert /><#if name?has_content>name="${name}_fld1_value"</#if><#if value2?has_content> value="${value2}"</#if><#if size?has_content> size="${size}"</#if><#if maxlength?has_content> maxlength="${maxlength}"</#if><#if autocomplete?has_content> autocomplete="off"</#if>/><#rt/>
    </@cell>
    <@cell class=class2>
      <#if titleStyle?has_content>
        <span class="${titleStyle}"><#rt/>
      </#if>
      <select name=<#if name?has_content>"${name}_fld1_op"</#if> class="selectBox"><#rt/>
        <option value="lessThan"<#if defaultOptionThru=="lessThan"> selected="selected"</#if>>${opLessThan?html}</option><#rt/>
        <option value="lessThanEqualTo"<#if defaultOptionThru=="lessThanEqualTo"> selected="selected"</#if>>${opLessThanEquals?html}</option><#rt/>
      </select><#rt/>
      <#if titleStyle?has_content>
        </span>
      </#if>
    </@cell>
  </@row>
</#macro>

<#-- migrated from @renderDisplayField form widget macro -->
<#macro field_display_widget type="" imageLocation="" idName="" description="" title="" class="" alert="" inPlaceEditorUrl="" 
    inPlaceEditorParams="" imageAlt="" collapse=false fieldTitleBlank=false tooltip="">
  <@field_display_markup_widget type=type imageLocation=imageLocation idName=idName description=description title=title class=class alert=alert inPlaceEditorUrl=inPlaceEditorUrl 
    inPlaceEditorParams=inPlaceEditorParams imageAlt=imageAlt collapse=false fieldTitleBlank=fieldTitleBlank tooltip=tooltip><#nested></@field_display_markup_widget>
</#macro>

<#-- field markup - may be overridden -->
<#macro field_display_markup_widget type="" imageLocation="" idName="" description="" title="" class="" alert="" inPlaceEditorUrl="" 
    inPlaceEditorParams="" imageAlt="" collapse=false fieldTitleBlank=false tooltip="" extraArgs...>
  <#if type?has_content && type=="image">
    <img src="${imageLocation}" alt="${imageAlt}"><#lt/>
  <#else>
    <#--
    <#if inPlaceEditorUrl?has_content || class?has_content || alert=="true" || title?has_content>
      <span<#if idName?has_content> id="cc_${idName}"</#if><#if title?has_content> title="${title}"</#if><@fieldClassStr classes=class alert=alert />><#t/>
    </#if>
    -->
    <#if description?has_content>
      ${description?replace("\n", "<br />")}<#t/>
    <#else>
      &nbsp;<#t/>
    </#if>
    <#--
    <#if inPlaceEditorUrl?has_content || class?has_content || alert=="true">
      </span><#lt/>
    </#if>
    <#if inPlaceEditorUrl?has_content && idName?has_content>
      <script language="JavaScript" type="text/javascript"><#lt/>
        ajaxInPlaceEditDisplayField('cc_${idName}', '${inPlaceEditorUrl}', ${inPlaceEditorParams});<#lt/>
      </script><#lt/>
    </#if>-->
  </#if>
  <#-- TODO: better tooltips -->
  <#if tooltip?has_content>
    <span class="tooltip">${tooltip}</span>
  </#if>
</#macro>

<#-- migrated from @renderField form widget macro -->
<#macro field_generic_widget text="" tooltip="">
  <@field_generic_markup_widget text=text tooltip=tooltip><#nested></@field_generic_markup_widget>
</#macro>

<#-- field markup - may be overridden -->
<#macro field_generic_markup_widget text="" tooltip="" extraArgs...>
  <#if text?has_content>
    ${text}<#t>
  <#else>
    <#nested><#t>
  </#if>
  <#-- TODO: better tooltips -->
  <#if tooltip?has_content>
    <span class="tooltip">${tooltip}</span>
  </#if>
</#macro>