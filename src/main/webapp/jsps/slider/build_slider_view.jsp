<%--
/**
 * Copyright (C) Rotterdam Community Solutions B.V.
 * http://www.rotterdam-cs.com
 *
 ***********************************************************************************************************************
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on
 * an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the
 * specific language governing permissions and limitations under the License.
 */
--%>
<%@ include file="/init.jsp"%>
<%		
    String slidesBuilder  = SliderUtil.buildSlides(renderRequest, renderResponse);
    String captionBuilder = SliderUtil.buildCaption(renderRequest, renderResponse);
    String sliderSettings  = SliderUtil.buildSliderSettings(renderRequest, renderResponse);
    String captionSettings  = SliderUtil.buildCaptionSettings(renderRequest, renderResponse);
    boolean displaySlide  = (slidesBuilder != null && !slidesBuilder.trim().equals(""));

    //Slides Themes
    PortletPreferences preferences = SliderUtil.getPreference(renderRequest, null);

    String themeValue = preferences.getValue(SliderParamUtil.SETTINGS_THEME, "default");
    String addCssClassValue = preferences.getValue(SliderParamUtil.SETTINGS_ADDITIONAL_CSS_CLASS, "");
    String widthValue = preferences.getValue(SliderParamUtil.SETTINGS_SLIDER_WIDTH, "618");
    String heightValue = preferences.getValue(SliderParamUtil.SETTINGS_SLIDER_HEIGHT, "246");
    String disableCaption = preferences.getValue(SliderParamUtil.SETTINGS_DISABLE_CAPTION, "false");

    if(Validator.isNull(widthValue))
        widthValue = "618";
    if(Validator.isNull(heightValue))
        heightValue = "246";
    themeValue = themeValue.toLowerCase();
    
    if(displaySlide) { 
        String inlineStyle = new StringBuilder("width: ").append(widthValue).append("px;")
                .append("height: ").append(heightValue).append("px;").toString();
        

%>
<!--<link rel="stylesheet" href="<%=renderRequest.getContextPath()%>/css/<%=themeValue%>/<%=themeValue%>.css" type="text/css" media="screen" />-->
<div class="theme-<%=themeValue%> <%=addCssClassValue%>" style="<%= inlineStyle %>">
    <div id="<portlet:namespace />slider" class="slider-wrapper">
        <%= slidesBuilder %>
    </div>
    <div class="clearfix"></div>
<%
    if(!"true".equalsIgnoreCase(disableCaption)) {
%>
    <div id="<portlet:namespace />caption" class="slider-desc-wrapper" >
        <%= captionBuilder %>
    </div>
<%
    }
%>
    <div id="<portlet:namespace />directionNav" class="directionNav" >
        <a class="prevNav"></a>
        <a class="nextNav"></a>
    </div>
    <div id="<portlet:namespace />pagination" class="pagination"></div>
</div>
<%  } else { %>
<center><b><liferay-ui:message key="message-no-slides-configured"></liferay-ui:message></b></center>
<%  } %>

<aui:script>
    $(document).ready(function() {
        $('#<portlet:namespace />slider').carouFredSel({<%=sliderSettings%>});
<%
    if(!"true".equalsIgnoreCase(disableCaption)) {
%>
        $('#<portlet:namespace />caption').carouFredSel({<%=captionSettings%>});
<%
    }
%>
    });
</aui:script>
