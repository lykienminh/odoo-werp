# -*- coding: utf-8 -*-
# from odoo import http


# class Werp(http.Controller):
#     @http.route('/werp/werp', auth='public')
#     def index(self, **kw):
#         return "Hello, world"

#     @http.route('/werp/werp/objects', auth='public')
#     def list(self, **kw):
#         return http.request.render('werp.listing', {
#             'root': '/werp/werp',
#             'objects': http.request.env['werp.werp'].search([]),
#         })

#     @http.route('/werp/werp/objects/<model("werp.werp"):obj>', auth='public')
#     def object(self, obj, **kw):
#         return http.request.render('werp.object', {
#             'object': obj
#         })
