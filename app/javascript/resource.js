import Axios from 'axios';

export default function newResource(url, options) {
  var httpClient = Axios;
  if (!options) {
    options = {};
  }

  function prepareUrl(params) {
    var adr = url;
    if (typeof url === "function")
      adr = url();
    params = Object.clone(params || {});
    Object.merge(params, options.params || {});
    Object.remove(params, (value, key) => value == null);
    var splitUrl = adr.split("/");
    var resourceUrl = splitUrl.map((r) => {
      if (r[0] == ":") {
        r = r.slice(1, r.length);
        var val = params[r];
        delete params[r];
        return String(val || "").escapeURL(true);
      }
      return r;
    }).join("/");
    if (!Object.isEmpty(params))
      resourceUrl = resourceUrl + "?" + Object.toQueryString(params);
    return resourceUrl;
  }

  function http(config) {
    config.headers = config.header || {};
    config.headers["X-CSRF-Token"] = document.querySelector('meta[name=csrf-token]').content;
    config.headers["X-Requested-With"] = "XMLHttpRequest";
    var onSuccess = config.onSuccess;
    delete config.onSuccess;
    var sort = config.sort;
    delete config.sort;
    var promise = new Promise(function(resolve, reject) {
      var req = httpClient(config);
      req = req.then((resp) => {
        //App.clearErrors();
        if (sort && sort.field && Object.isArray(resp.data))
          resp.data = resp.data.sortBy(sort.field, sort.desc == true);
        if (onSuccess)
          onSuccess(resp.data);
        return resolve(resp.data);
      }).catch((error) => {
        if (error.response && error.response.data) {
          //App.handleErrorResponse(error.response.data);
        } else {
          console.error(error);
        }
        return reject(error);
      });
      return req;
    })
    promise.catch(function() {});
    return promise;
  }

  var res = {
    get: (params, onSuccess) => {
      return http({
        method: "get",
        url: prepareUrl(params),
        onSuccess: onSuccess
      });
    },
    query: (params, onSuccess) => {
      return http({
        method: "get",
        url: prepareUrl(params),
        onSuccess: onSuccess,
        sort: {field: options.sort, desc: options.sortDesc}
      });
    },
    update: (params, data, onSuccess) => {
      return http({
        method: "put",
        url: prepareUrl(params),
        data: data,
        onSuccess: onSuccess
      });
    },
    save: (params, data, onSuccess) => {
      return http({
        method: "post",
        url: prepareUrl(params),
        data: data,
        onSuccess: onSuccess
      });
    },
    destroy: (params, onSuccess) => {
      return http({
        method: "delete",
        url: prepareUrl(params),
        onSuccess: onSuccess
      });
    },

  };
  res["delete"] = res.destroy;
  return res;
}
