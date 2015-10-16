module IndicatorVariableHelpers
  def build_indicator_variables(indicator_variables)
    indicators = Array.new

    unless indicator_variables.blank?
      indicator_variables.map { |indicator|
        indicators << {
          id: indicator.id,
          name: indicator.indicator.name,
          value: indicator.value
        }
      }
    end

    return indicators
  end
end

module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :idi do
      helpers IndicatorVariableHelpers

      desc "Return all indicator"
      get do
        idis = Array.new

        # Prepare conditions based on params
        valid_params = {
          tahun: 'year',
          provinsi: 'province'
        }
        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]

        TimeSerie.includes(:province, :indicator_variables)
          .where(conditions)
          .limit(limit)
          .offset(params[:offset])
          .each do |ts|

            idis << {
              id: ts.id,
              province: {
                id: ts.province.id,
                name: ts.province.name
              },
              year: ts.year,
              indicator: build_indicator_variables(ts.indicator_variables)
            }
        end

        {
          results: {
            count: idis.count,
            total: TimeSerie.count,
            idi: idis
          }
        }
      end
    end

    resource :provinces do
      desc "Return all provinces"
      get do
        provinces = Array.new

        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]

        Province.all
          .limit(limit)
          .offset(params[:offset])
          .each do |province|
            provinces << {
              id: province.id,
              nama: province.name
            }
        end

        {
          results: {
            count: provinces.count,
            total: Province.count,
            provinces: provinces
          }
        }
      end
    end

    resource :indicators do
      desc "Return all indicators"
      get do
        indicators = Array.new

        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 10 : params[:limit]

        Indicator.all
          .limit(limit)
          .offset(params[:offset])
          .each do |indicator|
            indicators << {
              id: indicator.id,
              name: indicator.name
            }
        end

        {
          results: {
            count: indicators.count,
            total: Indicator.count,
            indicators: indicators
          }
        }
      end
    end
  end
end