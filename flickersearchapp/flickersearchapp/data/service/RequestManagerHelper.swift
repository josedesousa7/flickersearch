//
//  RequestManagerHelper.swift
//  flickersearchapp
//
//  Created by José Marques on 10/10/2020.
//

import Foundation


class RequestManagerHelper: Decodable {

    func photosPathBuilder(page: Int, tags: String) -> String {
        return "\(APIConstants.baseURL)"+"?\(APIConstants.QueryParameters.method)=\(APIConstants.Url.search)" +
            "&\(APIConstants.QueryParameters.apiKey)=\(APIConstants.Authentication.APIkey)" +
            "&\(APIConstants.QueryParameters.tags)=\(tags)" +
            "&\(APIConstants.QueryParameters.page)=\(page)" +
            "&\(APIConstants.QueryParameters.format)=\(APIConstants.ParametersValues.json)" +
        "&\(APIConstants.QueryParameters.noJsonCallback)=\(APIConstants.ParametersValues.noJsonCallback)" +
        "&\(APIConstants.QueryParameters.perPage)=\(APIConstants.ParametersValues.perPage)"
    }

    func photoSizePathBuilder(id: String) -> String {
        return "\(APIConstants.baseURL)"+"?\(APIConstants.QueryParameters.method)=\(APIConstants.Url.sizes)" +
            "&\(APIConstants.QueryParameters.apiKey)=\(APIConstants.Authentication.APIkey)" +
            "&\(APIConstants.QueryParameters.photoId)=\(id)" +
            "&\(APIConstants.QueryParameters.format)=\(APIConstants.ParametersValues.json)" + "&\(APIConstants.QueryParameters.noJsonCallback)=\(APIConstants.ParametersValues.noJsonCallback)"
    }
}
