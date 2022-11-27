# -*- coding: utf-8 -*-
# from odoo import http


# class WerpPlus(http.Controller):
#     @http.route('/werp_plus/werp_plus', auth='public')
#     def index(self, **kw):
#         return "Hello, world"

#     @http.route('/werp_plus/werp_plus/objects', auth='public')
#     def list(self, **kw):
#         return http.request.render('werp_plus.listing', {
#             'root': '/werp_plus/werp_plus',
#             'objects': http.request.env['werp_plus.werp_plus'].search([]),
#         })

#     @http.route('/werp_plus/werp_plus/objects/<model("werp_plus.werp_plus"):obj>', auth='public')
#     def object(self, obj, **kw):
#         return http.request.render('werp_plus.object', {
#             'object': obj
#         })
