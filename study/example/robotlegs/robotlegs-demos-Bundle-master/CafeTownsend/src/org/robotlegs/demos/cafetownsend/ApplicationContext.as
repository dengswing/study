package org.robotlegs.demos.cafetownsend
{
import mx.resources.IResourceManager;
import mx.resources.ResourceManager;
import mx.rpc.http.HTTPService;
import mx.validators.EmailValidator;
import mx.validators.StringValidator;
import mx.validators.Validator;

import org.robotlegs.demos.cafetownsend.detail.model.EmployeeDetailModel;
import org.robotlegs.demos.cafetownsend.detail.view.EmployeeDetailMediator;
import org.robotlegs.demos.cafetownsend.detail.view.components.EmployeeDetail;
import org.robotlegs.demos.cafetownsend.detail.view.components.interfaces.IEmployeeDetail;
import org.robotlegs.demos.cafetownsend.list.model.EmployeeListModel;
import org.robotlegs.demos.cafetownsend.list.service.EmployeeListService;
import org.robotlegs.demos.cafetownsend.list.service.interfaces.IEmployeeListService;
import org.robotlegs.demos.cafetownsend.list.view.EmployeeListMediator;
import org.robotlegs.demos.cafetownsend.list.view.components.EmployeeList;
import org.robotlegs.demos.cafetownsend.list.view.components.interfaces.IEmployeeList;
import org.robotlegs.demos.cafetownsend.main.service.ResourceManagerService;
import org.robotlegs.demos.cafetownsend.main.service.interfaces.IResourceManagerService;
import org.robotlegs.demos.cafetownsend.main.view.MainMediator;
import org.robotlegs.demos.cafetownsend.main.view.components.Main;
import org.robotlegs.demos.cafetownsend.main.view.components.interfaces.IMain;
import org.robotlegs.demos.cafetownsend.user.controller.UserCommand;
import org.robotlegs.demos.cafetownsend.user.model.EmployeeLoginModel;
import org.robotlegs.demos.cafetownsend.user.model.events.EmployeeLoginEvent;
import org.robotlegs.demos.cafetownsend.user.service.MockEmployeeLoginService;
import org.robotlegs.demos.cafetownsend.user.service.interfaces.IEmployeeLoginService;
import org.robotlegs.demos.cafetownsend.user.view.EmployeeLoginMediator;
import org.robotlegs.demos.cafetownsend.user.view.components.EmployeeLogin;
import org.robotlegs.demos.cafetownsend.user.view.components.interfaces.IEmployeeLogin;
import org.robotlegs.mvcs.Context;

/** @author Jonathan Toland */
public class ApplicationContext extends Context
{
	
	override public function startup():void
	{
		mapMembership();
		mapModel();
		mapService();
		mapView();
		mapController();
		super.startup();
	}
	
	private function mapMembership():void
	{
		injector.mapValue(IResourceManager, ResourceManager.getInstance());
		injector.mapClass(HTTPService, HTTPService);
		injector.mapClass(Validator, StringValidator);
		injector.mapClass(Validator, EmailValidator, 'Email');
	}
	
	private function mapModel():void
	{
		injector.mapSingleton(EmployeeLoginModel);
		injector.mapSingleton(EmployeeListModel);
		injector.mapSingleton(EmployeeDetailModel);
	}
	
	private function mapService():void
	{
		injector.mapSingletonOf(IResourceManagerService, ResourceManagerService);
		injector.mapSingletonOf(IEmployeeLoginService, MockEmployeeLoginService);
		injector.mapSingletonOf(IEmployeeListService, EmployeeListService);
	}
	
	private function mapView():void
	{
		mediatorMap.mapView(Main, MainMediator, IMain);
		mediatorMap.mapView(EmployeeLogin, EmployeeLoginMediator, IEmployeeLogin);
		mediatorMap.mapView(EmployeeList, EmployeeListMediator, IEmployeeList);
		mediatorMap.mapView(EmployeeDetail, EmployeeDetailMediator, IEmployeeDetail);
	}
	
	private function mapController():void
	{
		commandMap.mapEvent(EmployeeLoginEvent.USER, UserCommand, EmployeeLoginEvent);
	}
	
}
}